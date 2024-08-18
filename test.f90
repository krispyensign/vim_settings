module matrix_module
  implicit none
  private
  public :: Matrix, allocate_matrix, deallocate_matrix, print_matrix

  type :: Matrix
    real, allocatable :: data(:,:)
    integer :: rows = 0
    integer :: cols = 0
  end type Matrix

contains

  subroutine allocate_matrix(mat, rows, cols)
    type(Matrix), intent(inout) :: mat
    integer, intent(in) :: rows, cols

    mat%rows = rows
    mat%cols = cols
    allocate(mat%data(rows, cols))
  end subroutine allocate_matrix

  subroutine deallocate_matrix(mat)
    type(Matrix), intent(inout) :: mat

    if (allocated(mat%data)) then
      deallocate(mat%data)
    end if
    mat%rows = 0
    mat%cols = 0
  end subroutine deallocate_matrix

  subroutine print_matrix(mat)
    type(Matrix), intent(in) :: mat
    integer :: i, j

    do i = 1, mat%rows
      do j = 1, mat%cols
        write(*, '(F6.2)', advance='no') mat%data(i, j)
      end do
      write(*, *)
    end do
  end subroutine print_matrix

end module matrix_module

program main
  use matrix_module
  implicit none

  type(Matrix) :: mat
  integer :: i, j

  call allocate_matrix(mat, 3, 3)

  ! Initialize the matrix with some values
  do i = 1, mat%rows
    do j = 1, mat%cols
      mat%data(i, j) = real(i * j)
    end do
  end do

  ! Print the matrix
  call print_matrix(mat)

  ! Deallocate the matrix
  call deallocate_matrix(mat)

end program main
