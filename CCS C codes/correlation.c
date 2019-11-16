/*
 * main.c
 */
#include<stdio.h>

void main()
{
	int x[10],h[10],y[10],a[10];

	int i,j,m,n,k,q;
                printf("Enter the length of x(n) :(m)  = ");
                scanf("%d",&m);
                printf("\nEnter the length of h(n) :(n)  = ");
                scanf("%d",&n);

                printf("Enter values for i/p x(n):\n");

                 for(i=0;i<m;i++)
                            scanf("%d",&x[i]);


                printf("Enter Values for i/p h(n) \n");
                for(i=0;i<n; i++)
                            scanf("%d",&h[i]);





            // padding of zeroes

				for(i=m;i<=n-1;i++)

							x[i]=0;



// reversing h(n)
				printf("Reversed h(n):\t");
	            for(j=0;j<n;j++)
                {
                    a[j]=h[n-j-1];
                    printf("%d\t",h[n-j-1]);


                }




				for(i=n;i<=m-1;i++)

							a[i]=0;


				i=0;

				while(i<m+n-1){
					y[i]=0;
					i++;
				}
//correlation

				for(i= 0;i<m;i++)
				{
					for(j=0;j<=i;j++)
					{

                        y[i] += x[j] * a[i-j];
                    }

                }
                k =(m>n)?m:n;
                k=2*m-2;
            //    printf("k:%d",k);
				for(i= m-1;i>0;i--)
							{
                                q= m-1;
                                for(j=i;j<=m-1;j++)
								// for(j=m-1;j>=i;j--)
                                {
									y[k] += x[j] * a[q];


                                    q--;

								}

                         k--;

							}


				printf("\nCorrelation of given sequences\n");
				for(i=0;i<m+n-1;i++)
 				{
					printf("%d \t",y[i]);
 				}
 }
