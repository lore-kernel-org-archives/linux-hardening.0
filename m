Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE093A7193
	for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393177; cv=none; b=nMaPMaB0DHnfnQfjJRrDqvHdMeGtJN50he8IPDEA2MguADty2AZTtImGQG/g4X31zYSC04tuiQ3M7PNzaVpQFwQ6/797q15qHNRqBhD5Lmbg9F1asfzow8BTvYyJaHJFGmYRN94oqSUXQNOvzs4RBdnGZek+z8AG9psWROtwxpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393177; c=relaxed/simple;
	bh=LLMb/HyjYW37Kr2Mya1c8bPVTQR1GTIw0/aQgy8v0sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Egg0hkQnQsC4/4B3TPgbIxJXGa5zx/C/7/ADHG1VXOpiBc/q/iO3gGu2/Oyzaqjlqb5aOfwHgK/eLgBgrZz0eeUNXiEJV9l7LFcD1u5rS5QW9qAyRLCBinnLuObuddMgCoBiNut2cVyFEmOp1xL7jXdN2L/SM86sFNd+P1BlUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=plZ6Ae7U; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="plZ6Ae7U"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e00eee27dso805316f8f.0
        for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 23:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792393174; x=1792997974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LLMb/HyjYW37Kr2Mya1c8bPVTQR1GTIw0/aQgy8v0sM=;
        b=plZ6Ae7U9Y49u8L8zdVLZqH67YBg9bHy9+JJCR3KF1uJR3dlsii0pc4KZDCorxHKN9
         tDcuXhrN8DsXy7jc9YchdgnH4XYcihrs5Wr9tSlnVUSSmp462YqYa2m3Zx0rWoQyPp5d
         TL1HM9/s4aXpIE3H/BzEUm6LA0IiF9tawTYDMefwvsfAVuuoshM3CfvJ/VJwbFlB0gsY
         97YqeWlrUyyVvjPHK/qYigdKMiEzcSC3j6ocqVDG0PMDzGGvBU/PQyNIdlvwgcvhX4+c
         DXuUjF3ccLeD9wF0Ec5hoTdDVon5h0ZhVtXfkqvsFA6JXsvc/u7TSfAa2EI3RMpCTYvd
         LfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792393174; x=1792997974;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLMb/HyjYW37Kr2Mya1c8bPVTQR1GTIw0/aQgy8v0sM=;
        b=riPDPkDO1CHnRPkHP36NdAT0Dcf+Ibc4z7rjA+E+NsdIS2zKrQTsRm8sVlKDs3asmF
         zrJtPJ6kmg8taA6Ul/yVSjVoIA3ppFDPotn2qOZRmrekKNAIItMQCmi+oqnfyZXnSUxr
         QeyGt+UUFtFkq1h4Q7dny1RSCWrovSbSBM8/jM0JCqRsYfdEoAUkQSU2H39uNAZhYenE
         MMfRKih+15HQ+KHXwUfxm0nixj155lqD7I5uD1X/snsu3kh/YRIACITZAo9Yu9CcNXzw
         CupRAZYlMZ58MMGP5atFffwzH9AHDLgvhw3CU+WgaL2r37/EgqiWlwLm1YOYc4XH22Q3
         xbJA==
X-Forwarded-Encrypted: i=1; AKwUvByY/p/L8SzpjOM4i5CRiAfOGduyToYWGyRyeP2x7muEqDvaT2jMYN0j1BT2v6/tkwJ7oqpGQEEEDcM3RbBuMDg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXytv4zlkdgXm16/ZCdfR3wYoDAkIbAsZC6RJ2WShbtS7PiHqb
	n0lJkkmjuAoFYyknJGVrV9qhwnscJB1RnO0iTyYkcSxp0RkjfUXnOJW6dcKIP8okXdE=
X-Gm-Gg: AYBFou15dw+VkKODGpTSa24Vvfx/mqKCb6/0ETCSwIyPtKFtH8K3g2FKkUYBMQzNxi7
	I+VSIdV0RGUScDCqJAaRCvlBGgYDL/Albboj38Ht/UXES7YpMKF9rmVV0JFJRSiNbkPlaOV+ZFB
	owhvfbVRTgzIoPvUD6AdTCvmAqLJ+76nGimkWu5BTlNGRAWqpR5xQA6ZgXsC5yBZBsOnz0nS9ra
	7SGIdyZmgqeX+MFWlJ2otT+Q67jVN3zAYwvr/uKNYlwArpnkIyLEaFRk3g64Mn8RtcA/dC2jvjQ
	MpabW8V7P7Jco567Jyi6GIXkYqqhz3InlQ6Y06QU10sLfjgimlBgoAJeagPasWJ5xG6tQFH+IdI
	1+MCQ5EJuAa7pOdUv9+Nfzea+llQjKA/0bUvpPXoeLo4nU1aZN27KlfQ1n6hFlaZG28fGefuYqU
	1bJX5wpxjQtAp7FoT/UWXAfg+Cfb94c2jHajWLhQ6dxAVv07cqrqhxHip/sMPvQE+anqpp150xe
	kW5M1ckVQQmn0s81cRYDuUj9oZoZP26bJxn9OUbEw/un7MvymCzXunglw5QCPA=
X-Received: by 2002:a05:6000:ad0:b0:48e:791:1cb with SMTP id ffacd0b85a97d-48e07fa71d0mr8663688f8f.35.1792393174300;
        Sun, 18 Oct 2026 23:59:34 -0700 (PDT)
Received: from localhost (p200300f65f19a9041674bacf58593a35.dip0.t-ipconnect.de. [2003:f6:5f19:a904:1674:bacf:5859:3a35])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48dfd471877sm17855976f8f.1.2026.10.18.23.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:59:32 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:59:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ross Cawston <ross@r-sc.ca>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: add driver for GPIO buses sharing one SCL line
Message-ID: <atW_fsT6BKTsgB7o@monoceros>
References: <20261018194315.945-1-ross@r-sc.ca>
 <20261018194315.945-3-ross@r-sc.ca>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="37wd2qfgr3nnmrjd"
Content-Disposition: inline
In-Reply-To: <20261018194315.945-3-ross@r-sc.ca>


--37wd2qfgr3nnmrjd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] i2c: add driver for GPIO buses sharing one SCL line
MIME-Version: 1.0

On Sun, Oct 18, 2026 at 12:43:15PM -0700, Ross Cawston wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

<linux/platform_device.h> already provides of_device_id, so there is no
need to also #include <linux/mod_devicetable.h> which also pulls in a
lot of unneeded dependencies.

Best regards
Uwe

--37wd2qfgr3nnmrjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrVv88ACgkQj4D7WH0S
/k6ZaggAoHAnurvLGEP3L6zNx3w+6ff5baOUBRRssiTdUqhb5qRZJoYoVEr2Y3Eg
iNbRJcltWL+Fb1/K3KMyPXBBDjMz8Y9SUVSIJpGTJcaWAjLYpUAxz6avmRzHKGbn
nF2zqNHukyx3nLFqKPIMOk9EUxS+9MJknWtgi1zDwKJzOQL/9Ga5+pr6ZKqWZ+Wj
hkZojOEmVsRVbjRcsa2lTp4hSxEkobPEHuN7x4tEWwF4atWSJfIHzf89kap0KIs2
r7eJiCjHY0ActrFxfVE+Mynl5FHZLA0xJsJQpfB/J1G9h2Wf0EAzba+vQjGNYAIN
CxJYxyMQGH1ehS326uzLwwPLFM1BAw==
=ZSot
-----END PGP SIGNATURE-----

--37wd2qfgr3nnmrjd--
