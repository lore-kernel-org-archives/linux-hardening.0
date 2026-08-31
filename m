Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD43C2B95
	for <linux-hardening@vger.kernel.org>; Mon, 31 Aug 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162802; cv=none; b=AIe21NTPYa9WG+zL++9Sa1O54XkWEvlMA1lIm1x5+brLMqx/AcqyP1Y6b44qFWoh7VW1hRVCymyWinWGexAGBWLly6n/s5mGXk/irCwjIUGcitKujTbeiE3ZkhZc0Lg9tSEBuYcNANG+kQy2WXFoyCeBZGQw4wGS+Tss89JfpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162802; c=relaxed/simple;
	bh=hK1ccgwDNp1FnzcsAtdYzKJecB9ZZzZ+gBEbbt719S0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=SfyTIfyupkQsRXyXeIEqS2H6Kaql8vyN+LCW8NfVNvJvSIDcs+RaZ0L1Emrc7EquIPqFE8w8B/cDXLdkueoZ+e+v9JdWYyXjK3EitcL8gnkbmXaOUqA5Ui6MCJ+2vY5kfle/0+zbtAOF+8rDqoG2eO1cl0cVyY18MT2fLfih1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=dbHc4avP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="dbHc4avP"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c25420fe973so5312366b.0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Aug 2026 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1788162799; x=1788767599; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8L251g5odZgk7HDZdrpqhA2gS9bIplpKlO5QvsDcLvo=;
        b=dbHc4avP35WRm5PY3nGdcWm9N5X2pyk72HxyAcfEeFyiKyd4E/rB13RKtcsiwITMpQ
         I5dATe8FgJkZX7ZZgIIKNBGrqb+BeaNVHbYkeAKjO9FdjvcY7cWBaxu7DKl3+2sRDtYT
         JynLrrXsoYuXT0qRAjL7Qz6Qei75w/FcM/PymEo8gHn3Iqy4N0wgVXNhi9+P+aCUo06b
         pxKq1p5MFKFufGSiTE8kP4ZHZKgzs2XYeR2Jg/U8Toh0iVIjT9X0R8DJ27ZbWJAdbXrS
         GxmDoKpf6DTi/YNLIUeyDBQtj2jVy2NLZTdeWHdA/9vvNL8keHdybc+myPHFX6mgeBwJ
         jMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162799; x=1788767599;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8L251g5odZgk7HDZdrpqhA2gS9bIplpKlO5QvsDcLvo=;
        b=ryYhiTYDgcr+iiucv0XOKkj/ZMz8Fxkcfk6hk+qCrkaYUBHTfOJBtHIdZAlNicEelU
         tf7R3oF87yk0zNR1xHvfZPV75mBIiNutKzZN9t0yREsoT8KsYFPiU7iOIrwSUIlYHzhn
         aL1ol7Y3Zb0zawFwUgSMORCt+/E5faRS9q4Eo/ntX0UIxFU0zlg1Xpd5iRUONTkj+8z+
         SbhdPNUWtAq/6V9DaquEmlOcJfQh7pBI3uxz6eXMxOpDYD2mqxVWEMvUo14DlD0IBrrL
         wwq7u1AVYd2bMF7bQlH92LsyIR3HF/19dUb3ZzOGzq76nx2Anm+UbzI6j/VroP/zMzK7
         w3Wg==
X-Forwarded-Encrypted: i=1; AHgh+RoCfki8G+3EYRej9Ubw1HFysv8W0RtrGeTw6VHFDI0ST+1jwBYM8Q3PTCI4GGzdxPbl2mDe5wl326dOQthiKWk=@vger.kernel.org
X-Gm-Message-State: AFuF++lu7DLKqxwVrUrt3ZRr6279LnBYTRRYCkTedGt8bWd/Itcgalpp
	bDGhGJFnMFiG5afitj2TGqxp0Qq28MKmGvXK3mpAqHfqcBesjyNrkChb87JkuLT7lbs=
X-Gm-Gg: AR+sD13B34ZvFqOmjjcN0Hz/3DX9aB4FQhZuGKeOW6fk7rWlWOY26iPlxybV+jnIfxU
	R+WfYM3EkNSZPFEp4o7Ntyy776nvK1zrNBcBVP/qYU3PQR2mM0Oejx2WPwT9BzgGqRpSpdgfDGI
	zhKrJsZxOUpzU1vez0XaDo/SpNwJCob6rR69OoCexM3vVLvWi7b5o8HReO1/Ha9vXc/M4tq6A5W
	ushBe58Nw/ucia+ZOgTHhAsR33XNNSA//vixyzHHQwZ1Ky4YhV+HcMmjSmPjUxzpFdPgSm/Pba0
	2Q/w4Vj1ca1B6XHRPCiNi+C7dp5SxiwUGtI2FqA21mwTxxyXaAKJHnrrQkU/jJc0rhY7sfH5C8H
	BU7FxgfEWQDfG1dvQcatTvir/b3RuWV/tXj9ITz/AUJQ9psuP55y3mHy1zDs4U6dAX+Avg7dYZL
	EyBZ1NUPGDBbpaA0Civ6grvfce2cng0bjiLRtqjdRk4o3Tpb0hJISIEKIiIWIX7oLbR57D+gmi7
	3+SmbMQfwwZMuZUh2TuGedshEByhUWuB3Bk/VmU0jYf
X-Received: by 2002:a17:906:4fd4:b0:c25:8878:3e09 with SMTP id a640c23a62f3a-c2588784f62mr520709566b.22.1788162798639;
        Mon, 31 Aug 2026 00:53:18 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1fa3ddsm378656166b.45.2026.08.31.00.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 00:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 09:53:17 +0200
Message-Id: <DL2YT4S4U7C4.2CPGBR94G01FD@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts.net>, "Marcelo Schmitt"
 <marcelo.schmitt1@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Luca
 Weiss" <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek
 STK36C61
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>
 <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64>
 <20260828154705.11962-1-jorijnvdgraaf@catcrafts.net>
 <apRGQVfPKWHvE2Ct@debian-BULLSEYE-live-builder-AMD64>
 <20260830201950.63838-1-jorijnvdgraaf@catcrafts.net>
In-Reply-To: <20260830201950.63838-1-jorijnvdgraaf@catcrafts.net>

Hi Jorijn,

On Sun Aug 30, 2026 at 10:19 PM CEST, Jorijn van der Graaf wrote:
> On Sun, Aug 30, 2026 at 12:03:29PM -0300, Marcelo Schmitt wrote:
>> Having a closer look at the data sheet I found for STK36C61, I noticed r=
egisters
>> 0x13 and 0x14 are not listed. Does the newer part has ambient light sens=
ing
>> besides the clear channel?
>
> That looks to be the "STK36C61-A Preliminary Datasheet v0.9" hosted by
> LCSC [1], which I hadn't found before, so the cover letter's "There is
> no public datasheet" is wrong. It documents the -A variant, however,
> and gives PDT_ID as 0x93, while the part in the Fairphone 6 reports
> 0x95. It does agree with the device on the colour-engine layout: RGBC

Just to chime in, the datasheet I have access to (STK36C61-A Preliminary
Datasheet Version - 0.9.2) there are a few changes compared with the one
from LCSC but nothing too interesting:

* On the overview page LED current 228.75 changed to 218.75 mA
* ALSCTRL1 register (0x02) has different values for BIT[6:4]
  (17.92 -> 143.36; 8.96 -> 35.84; 4.48 -> 8.96)
* PDT_ID is indeed 0x95 - maybe the previous version just had wrong
  copy-pasted info?

Hope this help.

Regards
Luca

> data at 0x15-0x1C, a clear-channel gain in GAINCTRL 0x4E, and the
> shared GAIN_RGB/IT_ALS fields in ALSCTRL1.
>
> Yes, there is ambient light sensing besides the clear channel:
> 0x13/0x14 are present on this device despite their absence from the
> datasheet map. They behave exactly like the stk3310's ALS data
> registers and are what the illuminance channel reads. The ALS word
> tracks the green channel exactly, proven by the x16 gain step moving
> both from 25 to 404. The sheet's own text does describe the function:
> it defines DATA_ALS[15:0] ("16-bits ALS channel raw data"), windows it
> with the THDH/THDL_ALS thresholds at 0x0A-0x0D, and calls FLG_ALS_INT
> "the Green channel out-of-windows event", which is consistent with the
> ALS =3D=3D green behaviour I measured.
>
> [1] https://www.lcsc.com/datasheet/C49230205.pdf
>
> Thanks,
> Jorijn

