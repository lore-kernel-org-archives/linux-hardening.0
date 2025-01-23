Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB18BF8;
	Thu, 23 Jan 2025 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737666615; cv=none; b=VZak9x46x6hqdL85vXva49ZcZmPjR65pVVa6nzH7wQdkDHe6ApDxKsNlnDkKb65AnifkaHAKXgGvUXwAF127K8+q+N5TYJVzMPKEH9SFB09xbuJBhnmB42sOAe52qw6hI8JeMG/sZObtjZA1yTsQY3vSck3tJtPCXLouVFXwlKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737666615; c=relaxed/simple;
	bh=65JytxFvSWLAVcI5ORQpUmFvVR6gFZ7eOagOp6Lt+t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvT1ZW4PpH9OIzEjbPlbE2syWYAc7tUTfY6mWGcd2dQnyaGTS7d3iKChACyi+q0kxm+hzuzzktjcL7GFZUmTDrskwwSf7pjPSJvm/YTBUBm6V7urd8/ioz0kTzkaxMW7iFuAkGbq2CYCcKDtQu4EWqPXdZPaJzyeseItOFNqU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBviw0gK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBviw0gK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436341f575fso15150005e9.1;
        Thu, 23 Jan 2025 13:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737666612; x=1738271412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELoXjbHMZaAjCLs6QPUpHBoArnQcIRTRV8IDYpOYDSk=;
        b=UBviw0gKjUdkSt4yAeURxSR7wVJMUGgeUSt/lEtD9L16lszu6U34YvMfjCMzVcZLop
         5WX9OAiXqNMqI+iYW1IbMRoSWNAbzQoLlNYzOw7ld56BDR0sJ2T9SaIilav1nMv8G92J
         tjChowbvidWLrSzyGjK98jP+H6F8U79qNh0x/0RuFZvsMmnrl+KvpCE3czdaH8vGx7uy
         6jaXgWpDPKqIoARvFjeN7tG8Ev8yreZzd77o6GLboxnc5pSGyumeVrCy2b6uVn/u1dth
         pGoL0m9kHH5kbEDJ5gnV2lZeySpH8c9JxHAYba/5vA4sCKMLKky7jyw0XqyBslNknh+A
         fvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737666612; x=1738271412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELoXjbHMZaAjCLs6QPUpHBoArnQcIRTRV8IDYpOYDSk=;
        b=QHUC5+iGhS4wo2942UrAiimxE8dohy8LBYrIn9jLkTfdEP+hP4XFFrBJYAjq/iSanf
         hSlFeTlnZ0B8in8PglgjhVOGLVKTFy7Wr1lNf6T2JCDfDzKsSIusYVFkeAh/cyCwWlyq
         TUgU9wQeuTzMU+5XAq0eqKOdyDUqizbVbQbS3Zsva61g/tcdZjMNZpJX9ej/1C4aO3DC
         tclvBriAUNFEOtxflSb+m/f0pTSk8KzV7zd5B1kWDeBaRKLixAbMToMKpbmoo7ARUGuf
         lXnaO0OJJVkRbfB9iFSQ2owp3bzImERmJzWOyl8gSNGvIWtlSGvgrIK/kHc/5x2FBoTf
         8iww==
X-Forwarded-Encrypted: i=1; AJvYcCU7W5OFzm6Yi4o0F21v5ir+IVs+hgeJ9iV571cdAaRCwggr6xXKZqt2qNR5ZOrFFunEH3ctOxHvsOk0+hKLy7U=@vger.kernel.org, AJvYcCUXpzcpiWgyZI7JWYwfitHysB3wukwXgE2/+zCne/ZveZY6HABE5P5CJ4aVB8uDfArcp0MfzQtTx/ZTfg3p@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6+Ph8MALNW44kPrRAJIkE5l1dc5XF9jx1JHYc6ycFhQKWibK
	0W/PK1sly+uoWkZbCU5rcS/Ji4pYGIfqk9HFiHqzucG9WKQzDTzB
X-Gm-Gg: ASbGncuc8CPnd+v/2+JN4mkuI+c1TNe4f7Q6HjS7w5Lywl8+598+/zaLLqLZyx5NLxP
	m1tEsoTAV/Jvcdaso/Gog3J1PgYAIAloNwp7T1PrYrbQj5+Up0bs9KQPg0IVlFQUiLwHoWsI4m6
	vGqkEVoDAENuRxar4FKk5I067NU4cDhlvvpzMBqvC4K86c0RABYrRQTeKSFkXbUXSmLKgkqq/d1
	bW5WOKf7Lm7uz8X21XlYSPpY6wwtzaFX+tvn/er0UNDWfEFMjygeLAGmJXtOzOY4BZKtYTuaxZd
	A9qkbbK4HeowgIeT/WjSjIxiOUMo48AEMgG7xRMb3Ug=
X-Google-Smtp-Source: AGHT+IHONke18rRnIkOTfp3jmTN6U3hXsf1EJcv0H5TdYIrzUApS6hiUKgStERhvikWZUTNlM28Mhw==
X-Received: by 2002:a05:600c:3c82:b0:434:f5c0:329f with SMTP id 5b1f17b1804b1-438913f08a2mr296700415e9.14.1737666611949;
        Thu, 23 Jan 2025 13:10:11 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f355sm4019755e9.4.2025.01.23.13.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 13:10:11 -0800 (PST)
Date: Thu, 23 Jan 2025 21:10:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Daniel Micay
 <danielmicay@gmail.com>, Paul Moore <paul@paul-moore.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: security: Allow default HARDENED_USERCOPY to be
 set at compile time
Message-ID: <20250123211010.4ec97055@pumpkin>
In-Reply-To: <202501221651.3F5A6ACD@keescook>
References: <20250122171925.25472-1-mgorman@techsingularity.net>
	<20250122171925.25472-3-mgorman@techsingularity.net>
	<202501221651.3F5A6ACD@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

...  
> > +config HARDENED_USERCOPY_DEFAULT_ON
> > +	bool "Harden memory copies by default"
> > +	depends on HARDENED_USERCOPY
> > +	default n  
> 
> This must be "default HARDENED_USERCOPY" or existing distro builds will
> break. All major distros enable this by default, and I don't want to
> risk HARDENED_USERCOPY_DEFAULT_ON getting missed and getting globally
> disabled.

It'll also cause grief for anyone trying to bisect.
Although that is always going to go wrong if it has been disabled.

I had 'fun' trying to locate a massive slowdown of a single threaded
program that was caused by a side effect of one of the speculative
execution mitigations getting enabled because the config parameter
got renamed.

	David
