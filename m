Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE72459EA
	for <linux-hardening@vger.kernel.org>; Sun,  7 Dec 2025 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765094709; cv=none; b=Ho/4Joaj6hUb4+GBIX6vJJe79PSYZ7c3KEHfOkML17YspLeT4XKjBlUOM0nErul31vw9I6iUtuRKw+krqfp5knO2Y+ds3l64G1WSUrId5xqqSlEhAzX83vXFOtipnwfKa8emf8269HZa4BS/f5v9FnQ3T2P7RuziFCo6ZLJVMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765094709; c=relaxed/simple;
	bh=u3VBf7nZ7V6oWtVB4N88DTum6HAok9ZrSwVvYxFRdys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQMjQjeCgpUGWnXQMvfP38D/Kc33lkD0MpHlhuL5C5l7cKr8jUOln/mYoqxI2/5a6fwP/9yvd/xSSp84LnazUVyKnBfEw9TqJOy1aAR2GBiweoaUxSfVdNtNojF5a9Dc/ryZmINQyVS9wa6lvVJyuwkrLwB+mZfqK5rD9whF0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5osyJex; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5osyJex"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so6008649a12.3
        for <linux-hardening@vger.kernel.org>; Sun, 07 Dec 2025 00:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765094706; x=1765699506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5q5Xq0sGlEaLAo2BW6b3E5rJGoYi1LAD4X7rgAhzhM=;
        b=G5osyJexw7WwXiGvu0sfCaSe5yndcLGVFG8gjNy7xMoRVyJEa1VQ6JlLTBATW49SVX
         VldfplwuzCb+yRSSE+huJ20l0EMLg1FGBoGr3PdBP42U+uu+Zfqq0vjTQukFmIvuIXAN
         cA8mhRAD8S4IU33q00G+AgSy96LGKpF7G4bVxHwHiWxh7djyPVefDEbUuPrmPH0sFAyf
         GDlTY6yJzset+iTHbh83w5K3qA/SWEfNbBXO6CLcS3j6JyUGs5v6l7TOHI3rhW2Xxz15
         +iulWeNbpRi5bHOzORc/87XbIpLi08iRuGUnDJ8qtfde6MMI0A1hE2eWlkh6/DMD1Aqx
         lv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765094706; x=1765699506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C5q5Xq0sGlEaLAo2BW6b3E5rJGoYi1LAD4X7rgAhzhM=;
        b=SQGhRPvSBlrIayEPx8WiZTVDfrQBPe2qFuQda9sNPEkMPde/YKdhiEtkUrEDz7My4Z
         4FOkRAldVa2nDw57gmmZtkMKuFtJfVoS7MABhzDQz4AyhxCzTubxgaD3aGpJFTPbVmwh
         xgL9jHlE2flXgJSzvUbOqQNG7f/w+0H92TOLWxybXuDQDcz0J+0EGG4FaKBxMzvVeUfr
         2NZULegrHZjVIlTXhLNqAu1+f2103RbzUFMFxhwoeRDhysSi05/uOzwsZIT31soDLdJ7
         GCMGHTRIAZTDkEKYkYK0BltAur6hC4QJbsCUjue6kycUm1JC6gJ4vyUorM3Lwe1v9HvK
         c6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA/D2t/rmtdsWWVlyjkx4KF3zSC4IbO0HunpFbQWQxMh4NMjX0V2XVLv7i+u7KsX/ad6giVV2FaoskEYqrAUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNmr3TU+1g5xWBqO+ppw7FBRFea5S0FITSWCeW0dvU7TeYzwL
	QQu6FZuhvhFx4b8IG7eep+XWoa9bTHX5bHOXXzcU1uGZOHZXwAEaHHyj
X-Gm-Gg: ASbGncs5xtU60vxez9kxLgj3ict4aEopnwJ0L0PnoBIRPL+oT6Fdymw8OgaroE3HTvQ
	7KLKjNkB9BQSR0xoFGX4NezUsRx6Gy9WrFUghV4on28GmkY/oY1eTMS1xBqYeRKweNdQYGOPUu9
	NEz3xw8S/KBb+f9XNrKldcNytl1YREsD/o5QR/LrhYP1qwneU1ODQvzOZ57r4tCWqVRxY8xAuhc
	1MNURYiinIN6qX53XzMLM+QBJAUr8dUd5eB3v/54jWMOa76mjADaEzGj6OKS3FjUyLE/0/FaUzS
	1uCypwBGRE5sRdF8ND6DHZAVavIbmAHCJzzcd959cZ4j4urCQXTC+jkK7NOJP/5Zb0/9I4KN4AI
	eYRrssGvX0RIx87HyQE5+TLfs6sDqT87RbLTQIEglUYfqBH8wiA1kCirOYajHF4BmE7Lu2m9GFV
	7N1IvHcX72v04Bvz50vZWb61Y=
X-Google-Smtp-Source: AGHT+IG3Fb6sFELWMDgiQ9Jhbis9xCT1Vxpk4srIFV8hPtA69hlwDRkseJRO10ljQ/uXJfKJ+qudEA==
X-Received: by 2002:a17:907:3e11:b0:b73:6e0d:4f6b with SMTP id a640c23a62f3a-b7a2476f945mr396070366b.36.1765094705602;
        Sun, 07 Dec 2025 00:05:05 -0800 (PST)
Received: from foxbook (bfg212.neoplus.adsl.tpnet.pl. [83.28.44.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4976c43sm813393666b.42.2025.12.07.00.05.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 Dec 2025 00:05:05 -0800 (PST)
Date: Sun, 7 Dec 2025 09:05:01 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Ping-Ke Shih
 <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>, "Jes.Sorensen@gmail.com"
 <Jes.Sorensen@gmail.com>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <20251207090501.41980a50.michal.pecio@gmail.com>
In-Reply-To: <2025120716-sway-hypnotic-8cb6@gregkh>
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
	<20251121111132.4435-1-zenmchen@gmail.com>
	<475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
	<c0d187d6fead4e5387db2a14129be96c@realtek.com>
	<44c9c325-14a8-4391-adce-4bbe8c68b446@gmail.com>
	<20251207001608.1f6940bf.michal.pecio@gmail.com>
	<2025120716-sway-hypnotic-8cb6@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Dec 2025 08:55:59 +0900, Greg KH wrote:
> On Sun, Dec 07, 2025 at 12:16:08AM +0100, Michal Pecio wrote:
> > Hi,
> >   
> > > >> I got something. In my case everything seemed fine until I
> > > >> unplugged the wifi adapter. And then the system still worked
> > > >> for a few minutes before it froze.  
> > 
> > Sounds like memory corruption.
> >   
> > > > Zenm and I tested below changes which can also reproduce the
> > > > symptom, so I wonder driver might assume urb is the first
> > > > member of struct, but unfortunately I can't find that.  
> > 
> > That's what it seems to be doing, because it uses usb_init_urb()
> > on urbs embedded in some struct and then usb_free_urb().
> > 
> > If you look what usb_free_urb() does, it decrements refcount and
> > attempts to free urb. But here urb is a member of a larger struct,
> > so I guess the whole struct is freed (and this was either
> > intentional or a bug that didn't happen to blow up yet).  
> 
> That's not ok at all, it's amazing this is working today.  urbs need
> to be "stand alone" structures and never embedded into anything else.

Is it though?

usb_init_urb() is exported and documented as below. Neither of which
suggests that the function must not be used by drivers.

/**
 * usb_init_urb - initializes a urb so that it can be used by a USB driver
 * @urb: pointer to the urb to initialize
 *
 * Initializes a urb so that the USB subsystem can use it properly.
 *
 * If a urb is created with a call to usb_alloc_urb() it is not
 * necessary to call this function.  Only use this if you allocate the
 * space for a struct urb on your own.  If you call this function, be
 * careful when freeing the memory for your urb that it is no longer in
 * use by the USB core.
 *
 * Only use this function if you _really_ understand what you are doing.
 */

I see that there are some sound drivers which embed URBs in larger
structures too, so if this is some tree-wide campaign there is a risk
of breaking them too.

Regards,
Michal
