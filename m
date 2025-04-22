Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212D38B
	for <linux-hardening@vger.kernel.org>; Tue, 22 Apr 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317750; cv=none; b=X08qkHUQxwk6kiSgMauWFZmGHFKNZccth25aOn2hIDZi7Um1ml9nL0q8ogV+YSMYYffpyRN1UXfpkzhFPC/UGficIfuzLJjj4U+tQdOaQHtUb8p+f3FDhn8wo/zq7iWcWc4VdDmJh/lVB/NUCSVV6w8JK4/NnEA657Ybg5tAddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317750; c=relaxed/simple;
	bh=OtKUFMsCCXQuyXdiECTB3D04cRKpceApukek+qlG2Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkTIYp9aoHK8XfEU3VVte/LP3wi/n5gyU6jfQWEJ5zsfAlYsum5KGgvbHKpPJjV08VVf6oQJbS+MGc7IxfuZp3pj3gU7x/nbkvvX573g1g/8JltTfl3Badnhjz7O1oAX3T0XVg1eJ7egDITKSW4QkJUJHQI2ujQDWXwTTCecGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.com; spf=pass smtp.mailfrom=inventec.com; dkim=pass (2048-bit key) header.d=inventec.com header.i=@inventec.com header.b=QKymG9BT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inventec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inventec.com header.i=@inventec.com header.b="QKymG9BT"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so5171304b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 22 Apr 2025 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inventec.com; s=google; t=1745317746; x=1745922546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wtwwt/qGVMfOAJ61/DZj57iTfzywR/wMkolYpyXZwMg=;
        b=QKymG9BTaQM/G9cl6fJZmX1DLUhOVviZlTuu7TEKn/JLEzF1C1oBOCeG7qYH7i9fmv
         CX1ciJbvdYkLqUj2qDmGnQjr/NjYTseiG3TQs9jDGD1q75jhbpXyx+IVe9hLIyKAJuPN
         2Wmrxxc+WlY4HnZnm3acXCvQpv+RaD8MA9EbNzCN0tDgwmdZa+b260/7OkQGncMoh8Jg
         diTGNiXX/w5uoOpGcerSSWr49haDExVjHl4FRYMKUc6ZXU8WMHjnuGMPxFEUJCJcTPq5
         N2tAJjHRQg1uuUoaPIapfIOu4YcmWjvHdyCZIFwGMwu68SfMqasogjvnZPE6J5s3Nh1E
         yjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745317746; x=1745922546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wtwwt/qGVMfOAJ61/DZj57iTfzywR/wMkolYpyXZwMg=;
        b=PrcfJs5rcBlCu6PBOT+vemZ4LUkAsh5pWDC+7l9c+nUUhOtom2bB8fG080bIHpa0vC
         wPyJm/xce2Vbz4KR2eerWV8jEqvwYp39uyEs+5BQcUW/hTLJME7D3z1fKfiaZpEOBS7a
         Vke8qwUATzUpV0moMrLBDWAdgfkyBIrIUhz/pj3Kywx8ZfebEnCiawNSO46JjZeNu0UG
         5Inzv4/+HWPq4fw/DRJBhbMBNthPiZ04GexboK+h1EsaUsGVxiGhB8ONgxkCvkZE8Vz/
         90BOV8rG6xHVE2ig4MA0+mMZ0qD1Op7NLQFaDif8KOxHdbN9fTFmQs+O+9tSDYGX61N7
         tUog==
X-Forwarded-Encrypted: i=1; AJvYcCWYzxCbUTgrJ0TIgvoyAyvD3ju3BclChKgaSp8GahhRGp06m1Lrq3khYXZWolatzUaLUIN8uyj5RU5ejLgja28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3RC5BLB6nABARMS5y8KBVH1/Z7uIQqoGPTzwbjiIWMvlFEr/h
	NugF+UlSypb8GIHPaRg8jsv+JgogzmouVZ7dg2E7LX3S7oPzDz9ml070E126FSE=
X-Gm-Gg: ASbGncs1FQw2W2XZQuBbulTG8eIkyzHH1DaBPjCf0woUqeYx37qLqNoJOyvX+hj2hnR
	x8x9/UAXqIMryS9cB/pNGN3opfJwY71TycHJJweg7RWDLesPhxuQKeqkmrFRta9cMc7NiuhWPJ6
	fryKTzXY0ipQ2kBy2hA/xzvKfOppkLIJUvR4smeCioUdkwdsOVe7AgQ/zaPjgJZuNdf+xJEr6D2
	NM48CSdAc1eOPZ30uNJ+eGBXd1sTRjtBkbd/oETQAjR2BNJ9zfW8PZ4RINpzLiRgbd5vLFFAFtD
	oZnOJE3RZW5uEhKXyxUHF9T7bw02VY0CCCmf+ERtqGx4dOklk+5FX3MgLm9tANnpdrcjw8pCpYs
	UZTQipBnYKjf10LdXK+aMq4i4hx2pZ7czrc2dW5sq9K00VfoPAeBN3EPPN2c=
X-Google-Smtp-Source: AGHT+IGWvQiFpLLb/JnK+vxMBI1uFfmAhPCio9warje9sSHRSfH/F8j7WFctbSygpqJcvFqmOTJrmg==
X-Received: by 2002:a05:6a21:3a83:b0:1e1:9e9f:ae4 with SMTP id adf61e73a8af0-203cc6e03e3mr20985847637.13.1745317745940;
        Tue, 22 Apr 2025 03:29:05 -0700 (PDT)
Received: from localhost.localdomain (60-250-242-163.hinet-ip.hinet.net. [60.250.242.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db13c1c40sm5541763a12.33.2025.04.22.03.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:29:05 -0700 (PDT)
From: Chiang Brian <chiang.brian@inventec.com>
X-Google-Original-From: Chiang Brian <chiang.brian@inventec.corp-partner.google.com>
To: linux@roeck-us.net
Cc: chiang.brian@inventec.com,
	gnoack@google.com,
	gpiccoli@igalia.com,
	jdelvare@suse.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	tony.luck@intel.com
Subject: Re: [PATCH v5] hwmon: (pmbus/tps53679) Add support for TPS53685
Date: Tue, 22 Apr 2025 18:20:57 +0800
Message-Id: <20250422102057.2846899-1-chiang.brian@inventec.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2628dd1f-1b8f-478a-aa89-4c0f78b27962@roeck-us.net>
References: <2628dd1f-1b8f-478a-aa89-4c0f78b27962@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 3/14/25 10:44, Guenter Roeck wrote:
> On 3/13/25 20:30, Chiang Brian wrote:
> > The TPS53685 is a fully AMD SVI3 compliant step down
> > controller with trans-inductor voltage regulator
> > (TLVR) topology support, dual channels, built-in
> > non-volatile memory (NVM), PMBus interface, and
> > full compatible with TI NexFET smart power
> > stages.
> > Add support for it to the tps53679 driver.
> > 
> > Signed-off-by: Chiang Brian <chiang.brian@inventec.com>
> > ---
> > v4 -> V5:
> >      1. document the compatible of tps53685 into dt-bindings
> > 	2. add the buffer length as argument for %*ph
> > 	3. Add Changelog
> > v3 -> V4:
> >      1. Add length comparison into the comparison of "id",or it may be true when
> > 	   the substring of "id" matches device id.
> > 	2. Restore `return 0;` in `tps53679_identify_chip()`
> > V2 -> V3:
> >      1. Remove the length comparsion in the comparison of "id".
> > V1 -> V2:
> > 	1. Modify subject and description to meet requirements
> > 	2. Add "tps53685" into enum chips with numeric order
> > 	3. Modify the content of marco "TPS53681_DEVICE_ID" from 0x81 to "\x81"
> > 	   Add marco "TPS53685_DEVICE_ID" with content "TIShP"
> > 	4. Modify the type of "id" from u16 to char* in `tps53679_identify_chip()`
> > 	5. Modify the comparison of "id". It will be true if the string "id" matches
> > 	   device ID and compare with type char*,
> > 	6. Add the length comparsion into the comparison of "id".
> > 	7. Modify "len" as return code in `tps53679_identify_chip()`
> > 	8. Output device error log with %*ph, instead of 0x%x\n"
> >      9. Use existing tps53679_identify_multiphase() with argument
> > 	   "TPS53685_DEVICE_ID" in tps53685_identify() rather than creating one
> > 	   tps53685_identify_multiphase()
> > 
> > boot-log:
> 
> This is completely useless noise.

Sorry for the delay, I've got the approval for posting the boot-log from our 
customer. I was afraid that there's any confidential information in the boot-log
of our project. So, I decided to post a boot-log with my laptop then, and I'll 
append a new one once new patch has been finished and uploaded. 

And thanks for the suggestion of adding a buffer length for %*ph.
The kernel crashes and keeps rebooting without adding that.

In addition, should I in-reply-to the existing thread or create a new one 
since the dt-bindings should be included in the same thread as well?

Thank you.

Best Regards,
Brian Chiang
