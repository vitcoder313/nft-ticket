import React from 'react';
import Image from 'next/image';
import {useRouter} from 'next/router';

//INTERNAL IMPORT
import Style from './HeroSection.module.css';
import {Button} from '..';
import images from '../../img';

export const HeroSection = () => {
  const router = useRouter();
  return (
    <div className={Style.heroSection}>
      <div className={Style.heroSection_box}>
        <div className={Style.heroSection_box_left}>
          <h1>Event, Ticket, and sell NFTs 🖼️</h1>
          <p>Discover the most outstanding NTFs in all topics of life. Creative your NTFs and sell them</p>
          <Button btnName="Start your search" handleClick={() => router.push('/searchPage')} />
        </div>
        <div className={Style.heroSection_box_right}>
          <Image src={images.hero} alt="Hero section" width={600} height={600} />
        </div>
      </div>
    </div>
  );
};
