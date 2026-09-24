Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D14C753C
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278552; cv=none; b=opJ9nhfCQpsdMjW6lkw2cBilXBYuOosM8kPi3tS0xD3znUWLDyd8gRpZPWS+I+rkh2FoPnHgVhsKDRhk1dqsJ4cR5BbhJG2gd8wIgn6j0lMtyQJtGAK2Q37LfGOcLEO+yKfcKdmTbAPOW0j82cMnTy3PYutlN+2PuJGBlY7IuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278552; c=relaxed/simple;
	bh=Q9V/OyxnzpEXhb1+HiEXe9l33vd3hEia2l4gk0QcaEc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SrqoxFfPW22KEvWYMhqhyFGLKPJPbMFhZR8Wx0Me8YXzkJokBSWSbpgVuCmhGTOw7WMgxhsMs2kKmv1GnFnCQ7KB9MfJtpZvU3qQ2mJwS4s9yOhgOITTpBM87tRuRLqVYPzDNOoCeNaZJQtiNDkeDmbqXszDnrT4m1XOf0+tBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyxDHMEw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyxDHMEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790278541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faoj1Myu+9icVQdUpGQqIdpGYG/tK6O2kdZEgu4Y+4w=;
	b=GyxDHMEw9Ice88SdB3avp+QzveJ3pGOAyczCrL8fZYS1/Dq97t5ivMapi+8TW3nZRq6VyW
	5FNLy9PT+NNFpH2cTpWvUYxvaSYgpbBfzMIVjCF6cb7AsQIJxMd5W2fXLSvPAO7jJFj13X
	6/DHU7iyl5eSj33XW/vXNRP2Ik+cPpI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-9bfs2KuENjCYNS9b9KW57g-1; Thu, 24 Sep 2026 15:35:39 -0400
X-MC-Unique: 9bfs2KuENjCYNS9b9KW57g-1
X-Mimecast-MFC-AGG-ID: 9bfs2KuENjCYNS9b9KW57g_1790278539
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-836caf085e0so2995337b3.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 12:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278539; x=1790883339;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=faoj1Myu+9icVQdUpGQqIdpGYG/tK6O2kdZEgu4Y+4w=;
        b=ZP/hmNNa2dcwxYaMjvEtcXOkxAK4TkjCnlsNZYA48SBcgwvVZmgmutFIsTJSL+Hbsj
         TXKtp40eSvFbbGkx8Z5twD3yGgM8o/3c+ra0dckpCAI5zgmn+7EB9S4169fJ8CuCyU9u
         e/6KGPU8lxAt6Fq7OQtBHj4nkFSXSr/Hw1ApYXZW+wbOzxq+AhqKC4VQi6v+TRUK/BzJ
         CxFHL+N2JlnMErhPFMwSHCfnRyDyj7jly7AWM6HEXd6kx4aHk8FAsbNBuzKYbK8LY9lF
         wRVOt8ENhbiDIRq4U0dJ6ob4bHPoHRkNQBuevTMwEsvLzFQef+XQwphiXdOCN+FFoE+e
         TPkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx59bUQqfAweSTTrmnhYRk4EXoXpu2Z7G1YJV/rRjthv7c0m1Xn8vNMl23znml7zo+HorlmYVHJhKlCbaYW5T0=@vger.kernel.org
X-Gm-Message-State: AFuF++nVqiRqgEdedXa97NgAZCZJuvFY9XQbqTqWYLpEGf2eIN/hwn7w
	oimyDIo8l67kXgOhyoXl3p7U3O9q2WWeSFXcEBq93VSFQ2wyi2wb9DsxGm3Is7A7cMeVz8M5Lzf
	/f22QXFZnj7PTLsNxmBqBIyyK069wvtGDIWtUv01Pc+GzMO8BI1M1qyEhIGSXrDKp7w8lYyqTax
	H66Q==
X-Gm-Gg: AYBFou2GrnAnJVRKIBw3AwAt2pV7h9KCrOIIvD7u5zD6DsI4uA6TdzNS4Ss5tOVQ5Yj
	e50i86++QqKLQwWtgd0b71rGKdI4mxq8GhFBEZq0ijbUzTwbk3OmNSCNSsP1C1AWN3gSjVbH1uc
	cD+iJd7OHaTG7K70w3F1B20HYKAZwNmdE68Rr5z3s5D+kbVT6HEBWoT7VdhFCBMzYSDY96kgHWi
	5u5fVzQeGxtKra3l58KESVTOS/x1QStRlUWXjV4If84mYKO1MIwRtJJHIwYg56cSdhyhNFheNn5
	dCkoo3bCwxYe1gJ1WLssBpYT1J1QqGTGlWCgKX5e+T6AoOEdbfmdYXdsR4euEB/ZEvWtjxbC/EU
	tsMe8qmc=
X-Received: by 2002:a05:690c:e21a:10b0:89b:689d:3a73 with SMTP id 00721157ae682-8a64968736bmr19121847b3.42.1790278539150;
        Thu, 24 Sep 2026 12:35:39 -0700 (PDT)
X-Received: by 2002:a05:690c:e21a:10b0:89b:689d:3a73 with SMTP id 00721157ae682-8a64968736bmr19121737b3.42.1790278538479;
        Thu, 24 Sep 2026 12:35:38 -0700 (PDT)
Received: from [192.168.134.224] ([2600:382:8501:4f43:e566:7498:c7c8:a7ec])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860fbcb2csm997117b3.25.2026.09.24.12.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:35:37 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: Gregory Clement <gregory.clement@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 linux-hardening@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <AS8P251MB000199E5C86A0447B3FC48EDC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB000199E5C86A0447B3FC48EDC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] clk: mvebu: ap-cpu-clk: Assign .num before accessing
 .hws
Message-Id: <179027850326.211017.6896107198657392154.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:35:03 -0400
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=317; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=90S9+JQ9kh2224ZVg9ldJrz1f/1vkihNmKSNrXDf66s=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLK2Vrf4iC9aYqXVz71kbdH+Ov1saU+nCVp74zj/zdWyX
 mEz/UV/RykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABO5x8HwP+Xe94k/F3Qz7le/
 aWa/fb275ucvfCwNMmdm2e078PxT8TyG//k/v/++Pquid3fu0QMaWlpS1TdcLl8o4LMx/e64uC9
 zATMA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6jLJ_jDoh4NJCDmohM6jpWn2evcXqln4ueVnXh8KU-g_1790278539
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


On Sat, 05 Sep 2026 21:48:07 +0100, Aamir Ahmed wrote:
> clk: mvebu: ap-cpu-clk: Assign .num before accessing .hws

Applied, thanks!

[1/1] clk: mvebu: ap-cpu-clk: Assign .num before accessing .hws
      commit: b4243850393f2f24e21b9f4b2c56233e60c904b4

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

