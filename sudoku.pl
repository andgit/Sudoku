#!/usr/bin/perl

@sudoku=
(
	[6,7,1,3,5,8,2,4,9],
	[8,9,3,7,4,2,6,5,1],
	[2,4,5,9,6,1,8,7,3],
	[4,5,9,6,7,3,1,2,8],
	[3,6,8,1,2,5,7,9,4],
	[7,1,2,8,9,4,3,6,5],
	[9,3,4,2,1,7,5,8,6],
	[1,2,6,5,8,9,4,3,7],
	[5,8,7,4,3,6,9,1,2]
);

@tab=(1,2,3,4,5,6,7,8,9);
@wektor;
$temp=0;

sub clear	#czyszczenie wektora
{
	for($m=0;$m<scalar(@wektor);$m++)
	{
		$wektor[$m]=0;
	}
}

sub push_back	#dodawanie na koniec wektora
{
	$wektor[scalar(@wektor)]=$temp;
}

sub wyswielt_macierz
{
	print "+-----------------------+\n";
	
	for($x=0;$x<9;$x++)
	{
		print "| ";
		
		for($y=0;$y<9;$y++)
		{
			if(($y%9)==0 && $x!=0)
			{
				print "\n| ";
			}
			print "$sudoku[$x][$y] ";
			
			if($y==2||$y==5)
			{
				print "| ";
			}
		}
		
		if($x==2||$x==5)
		{
			print "|\n|-------+-------+-------";
		}
	}
	print "|\n+-----------------------+\n";
}

sub wyswielt_macierz_wyg	
{
	print "+-------------------+\n";
	
	for($x=0;$x<9;$x++)
	{
		print "| ";
		
		for($y=0;$y<9;$y++)
		{
			if(($y%9)==0 && $x!=0)
			{
				print "\n| ";
			}
			print "$wygenerowane_sudoku[$x][$y] ";
		}
	}
	print "|\n+-------------------+\n";
}

sub ustaw_sudoku
{
	$liczba_zerowych=0;
	
	if($poziom_trudnosci==1)
	{
		$liczba_zerowych=50;
	}
	elsif($poziom_trudnosci==2)
	{
		$liczba_zerowych=60;
	}
	else
	{
		$liczba_zerowych=70;
	}

	do
	{
		$temp_rand_x=-1;
		$temp_rand_y=-1;
		$rand_x=int(rand(9));
		$rand_y=int(rand(9));
		
		if($sudoku[$rand_x][$rand_y]!=0 && ($rand_x!=$temp_rand_x || $rand_y!=$temp_rand_y))
		{
			$sudoku[$rand_x][$rand_y]=" ";
			--$liczba_zerowych;
		}
		
		$temp_rand_x=$rand_x;
		$temp_rand_y=$rand_y;
		
	}while($liczba_zerowych);
}

sub sprawdz_sudoku
{
	for($i=0;$i<9;$i++)
	{
		for($j=0;$j<9;$j++)
		{
			$temp=$sudoku[$i][$j];
			
			if($temp==" ")
			{
				return false;
			}
			else
			{
				for($k=0;$k<9;$k++)
				{
					if($temp==$tab[$k])
					{
						for($l=0;$l<scalar(@wektor);$l++)
						{
							if($wektor[$l]==$temp)
							{
								#print "Niepoprawnie rozwiazane sudoku\n";
								return false;
							}
						}
						push_back(@wektor, $temp);
						$temp=0;
					}
				}
			}
		}
		clear(@wektor);
	}
	return true;
}

sub skopiuj_macierz
{
	for($a=0;$a<9;$a++)
	{
		for($b=0;$b<9;$b++)
		{
			$wygenerowane_sudoku[$a][$b]=$sudoku[$a][$b];
		}
	}
}

sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

###################################################################################################
print "\n______Witaj w grze Sudoku______\n\n";

print "______Podaj jaki poziom trudnosci wybierasz - 1,2 lub 3______\n";

$poziom_trudnosci=<>;

ustaw_sudoku(@sudokus, $poziom_trudnosci);

print "______Rozpoczynamy gre. Oto wygenerowane sudoku:______\n\n";

wyswielt_macierz(@sudoku);

skopiuj_macierz(@wygenerowane_sudoku,@sudoku);	#wygenerowan_sudoku - po to by gracz nie mogl zmienic pol ktore byly ustalone pierwotnie

$poprawne;

do
{
	print "Podaj wiersz oraz kolumne [1-9][1-9] oraz wartosc jaka chcesz wstawic:\n";
	
	$wiersz=<>;
	$kolumna=<>;
	$wartosc=<>;
	--$wiersz;
	--$kolumna;
	
	if(($wiersz>=0&&$wiersz<9)&&($kolumna>=0&&$kolumna<9)&&($wartosc>0&&$wartosc<10)&&$wygenerowane_sudoku[$wiersz][$kolumna]==" ")
	{
		$sudoku[$wiersz][$kolumna]=trim($wartosc);
	}
	else
	{
		print "______!Podales nieprawidlowe wartosci!______\n";
	}
	
	wyswielt_macierz(@sudoku);
	
	$poprawne=sprawdz_sudoku();
	
}while($poprawne);

print "\n______Koniec gry. Sudoku rozwiazane poprawnie.______\n"



