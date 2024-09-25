Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779414AD19
	for <linux-hardening@vger.kernel.org>; Wed, 25 Sep 2024 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258596; cv=none; b=eWQZtFAP0B7LFxPcgvDpFJJOf7i9qIuzl/YFQhbG7nD9QROBJu9PMbrWVMikD9h+NqrzfCcrraC6nduAgp4CIFafZh45xHtsBkbK0+U9PM+mNluXrs0F7uhUmZUZ/8MusOtunwunBscrRZVBkj5mhbat+sz2rrtjkkwNQ0FuYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258596; c=relaxed/simple;
	bh=OAd2wIpfSuZnzvFSzVNB1KEZT75H+jUQjzBdirf0kew=;
	h=Message-ID:Content-Type:MIME-Version:Subject:To:From:Date; b=NMQ/LuKr3PElCwufd2LquAUSjbwtq3g6Q+FnVoSpiubnvYnhS5+CUAPUVm1AtZiSJwe4OVNy7XZgMpOHjFOI/TUzkO9HGLRMMaxMpfmTMBdYEbXGBXazVeHqP7Kt+DWOWRDS+CkcsOLKxNO8LgNuJGIYIDvAfe7hoYITPQMppjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNDXEZP6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNDXEZP6"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso8288390a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 25 Sep 2024 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727258593; x=1727863393; darn=vger.kernel.org;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAd2wIpfSuZnzvFSzVNB1KEZT75H+jUQjzBdirf0kew=;
        b=CNDXEZP61TlJC8QUa1VsXLLKRJ3KUw2LiqaajmBwNLCU4Y+jOV+K0neXkftVj1hP7r
         scUexxbZ/jI1o90q2Rnw5vI3QbH/VBTEqMUodbvreDrMJBacvMqrau79sRAKuDUXvkor
         KGsteM3PB2HbcT3RgcZnbyvbYbetm+7kgNnaD/c9M0XAZby25Y4ZM9mi5Oypj+WeADzq
         WA6aR3ZmfyWqj9ttsaMaSW95vdQkuHY65lJALo1qsFYvoXPZvwaTD1v0riUpdfAXBT3I
         bdbMKvbVhF7Q8VVsFV57dpvq8RdEsVVwuV+oxci0m8pCwsnhbbUGgVyxJezoxc0c8pHs
         WB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727258593; x=1727863393;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAd2wIpfSuZnzvFSzVNB1KEZT75H+jUQjzBdirf0kew=;
        b=HWDzp9jSlAYUz5q/V/LsfoUsGrlXEM/YYLbujauEVf2p95vLskI3OAUxemSFqeC6pK
         GYp2eKIO4VLliGWmOizaxclGWVgAJG3nIsO60QjwGqmuy6NnOktRTCKwRAkRY569ZReR
         tr6ueCEH7Nl2v7ETUg2pnGwQJhEN7d69bwt2dWM5hBi0WkD70sCTp1zpmydfjhVwazJr
         xahrdwsb7VnMqdh6aBUv2KPVz878W1MSGsDyO+sOrUA8sH54NkA9+R2teCvBynrPIxyl
         yfLn7Obwjo7ZOaHbbCDehepVoAB70k518k+Vb6daHMVrbbQ0lwdAjueY+OtexH6Y+g0H
         amCQ==
X-Gm-Message-State: AOJu0Yy/ymPhyI+j69pm3dBzZaRuMTvawS7Phoz/eSPmKcpQ2ocXihcn
	UsDrAvSLFGudq08Unf094nL8VJ9j9QBz+51DxaQM98PEVYR4nUeFCO28HP3B5gU=
X-Google-Smtp-Source: AGHT+IGpzIonjpK5HMZWuEhLWtoB2HTKhovvd3vBQp38Iy1OThcGKxjiHGmxe2d7voUU1Ds9qRbbfg==
X-Received: by 2002:a05:6402:234f:b0:5c7:a054:767d with SMTP id 4fb4d7f45d1cf-5c7a05479dcmr342112a12.4.1727258592920;
        Wed, 25 Sep 2024 03:03:12 -0700 (PDT)
Received: from [10.2.0.2] ([149.102.239.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c059sm1676545a12.8.2024.09.25.03.03.08
        for <linux-hardening@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Sep 2024 03:03:10 -0700 (PDT)
Message-ID: <66f3dfde.a70a0220.24655b.66c9@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: LAST REMINDER ABOUT YOUR RECOVERED FUNDS,,
To: linux-hardening@vger.kernel.org
From: johnkann26@gmail.com
Date: Wed, 25 Sep 2024 03:03:07 -0700
Reply-To: johnkhan28@tutamail.com


LAST REMINDER ABOUT YOUR RECOVERED FUNDS
DEAR.BENEFICIARY,,
I am Attorney , from England, I am a senior attorney assigned by the Britis=
h government to visit all banks within the UK and Europe and Africa. To det=
ect and monitor all affairs of all banks, in one of my visits I saw a file =
in your name attached with your email address,

I have been working on recovering your funds back to the UK because the gov=
ernment told me once the funds are in the UK, every document needed to deli=
ver your funds to you will be made available by the British government, I a=
m writing to you today because I recovered your funds last Friday. Your fun=
ds is deposited with Bank UK, in the amount of USD$2Mliion ,

kindly send me your details and how you want to receive your funds so I can=
 pass your file to the paying bank.

Best Regards

If you are ready do let me know,

Have a nice day.
JOHN KHAN
LAWYER ASSISTANCE AGENT TO THE BANK
