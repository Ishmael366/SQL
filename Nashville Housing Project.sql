/*

Cleaning Data in SQL Queries

*/


Select *
From  NashvilleHousing.nashvillehousing;

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


SELECT 
    STR_TO_DATE(SaleDate, '%M %d, %Y') AS saleDateConverted
FROM 
    NashvilleHousing.nashvillehousing;


UPDATE NashvilleHousing
SET SaleDate = STR_TO_DATE(SaleDate, '%M %d, %Y');


 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
From  NashvilleHousing.nashvillehousing
order by ParcelID;

SELECT 
    a.ParcelID, 
    a.PropertyAddress AS AddressA, 
    b.ParcelID, 
    b.PropertyAddress AS AddressB, 
    IFNULL(a.PropertyAddress, b.PropertyAddress) AS MergedAddress
FROM 
    NashvilleHousing.nashvillehousing a
JOIN 
    NashvilleHousing.nashvillehousing b
    ON a.ParcelID = b.ParcelID AND a.UniqueID != b.UniqueID
WHERE 
    a.PropertyAddress IS NULL;


UPDATE NashvilleHousing.nashvillehousing a
JOIN NashvilleHousing.nashvillehousing b
    ON a.ParcelID = b.ParcelID AND a.UniqueID != b.UniqueID
SET a.PropertyAddress = IFNULL(a.PropertyAddress, b.PropertyAddress)
WHERE a.PropertyAddress IS NULL;


--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress
From  NashvilleHousing.nashvillehousing;

-- Add new columns
ALTER TABLE NashvilleHousing.nashvillehousing
ADD COLUMN PropertySplitAddress VARCHAR(255),
ADD COLUMN PropertySplitCity VARCHAR(255);

-- Update new columns using SUBSTRING_INDEX
UPDATE NashvilleHousing.nashvillehousing
SET 
    PropertySplitAddress = SUBSTRING_INDEX(PropertyAddress, ',', 1),
    PropertySplitCity = TRIM(SUBSTRING_INDEX(PropertyAddress, ',', -1));

Select *
From  NashvilleHousing.nashvillehousing;





Select OwnerAddress
From  NashvilleHousing.nashvillehousing;

ALTER TABLE NashvilleHousing.nashvillehousing
ADD COLUMN OwnerSplitAddress VARCHAR(255),
ADD COLUMN OwnerSplitCity VARCHAR(255),
ADD COLUMN OwnerSplitState VARCHAR(255);

UPDATE NashvilleHousing.nashvillehousing
SET 
  OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1),
  OwnerSplitCity    = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1)),
  OwnerSplitState   = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1));

Select *
From  NashvilleHousing.nashvillehousing;




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From NashvilleHousing.nashvillehousing
Group by SoldAsVacant
order by 2;

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From  NashvilleHousing.nashvillehousing;

Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END;






-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From  NashvilleHousing.nashvillehousing
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress;

WITH RowNumCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
               ORDER BY UniqueID
           ) AS row_num
    FROM NashvilleHousing.nashvillehousing
)
DELETE FROM NashvilleHousing.nashvillehousing
WHERE UniqueID IN (
    SELECT UniqueID
    FROM RowNumCTE
    WHERE row_num > 1
);

Select *
From  NashvilleHousing.nashvillehousing;




---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

Select *
From  NashvilleHousing.nashvillehousing;


ALTER TABLE NashvilleHousing.nashvillehousing
DROP COLUMN OwnerAddress,
DROP COLUMN TaxDistrict,
DROP COLUMN PropertyAddress,
DROP COLUMN SaleDate;
















