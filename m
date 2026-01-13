Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196439340C
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313649; cv=none; b=OoLkyM6BjFJrfmWlUcR7I7GTMK45i+DKWja1ZpkxMRBHNUOhK1/ZaryMAW9EWFA6okeiIHboCZPH6X+hmSZb1tho6jYlbFhWMJ4xUdOMyAufYlCG6nEv/eHmw/Z6v9ADnY0aRbpGKUyP5E3F+ZdxdM4XcQFuXX9nUlC547rzw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313649; c=relaxed/simple;
	bh=Yh/skuOQuC/zZ/fQfc54UBUifN3ebScHgpu0xUQPYSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVtpZGXfDsIVWw5sj9FS+Am6jgHi7/oWxnRxbr6tHeULtYL6WKTL+0iYAH4dLjn100lq2TdyBVAbKBOQUqev7fxBSznydOpIP1TbXIEvCbfQCmFv7nnM1kg85ZdkR2mWyLBk0ZU7ZbpI3K5sAASZnGlRv8mVPwZv0R18aFMJky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkK2yDQ0; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkK2yDQ0"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc4b952cc9dso3224884a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 06:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768313643; x=1768918443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh/skuOQuC/zZ/fQfc54UBUifN3ebScHgpu0xUQPYSk=;
        b=FkK2yDQ0gdrvpsMBaScW+qvQ/ok3On1tPM9wAIf9HZvAfV+wz8Cg0/AeF0+qhQ3zDj
         J8pLhylFsLI76gMWMb/tTQ2Gp4WGPQ/Rhvie5wfnhWQ0GF+XgEFs6O80iSSOpyGdEmbh
         ECrhFW/bDJrpJzYCDk7Vhde2GE6Dl7qxnIndtsGfGfgR/7ryxFIJSMSAmqyt5FEEAjDD
         Xbkesv9BQ1mPoHIc4OGx5GyoIrxxWc1cWXJPcCwlw3bYE4mq/XRMBVLITr5e+DW4mlhz
         RZxeNxUmaA+bgbGVXI4gTWAApRStrrLRoTJi+GIAt36sC+yWxiJD7ie7FMg8Ffj1/Rry
         NRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768313643; x=1768918443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yh/skuOQuC/zZ/fQfc54UBUifN3ebScHgpu0xUQPYSk=;
        b=EteK1Yym8EIxqCve9naJel231286DcKkyHXqYllucJREN37Z2BtCWVtuxeXFgAJex+
         a48h/0SVIUMQrEE03dtme29bPoGlamPedqxQCHkgTZZgS37TAlbDZoos/6VFvlmXPAPV
         +U/elGspmBMh8Z5BQNKnugw/LLkLhfGit3HFHkhlXNxy5cqnrXdh//HeV4rLv12iWD1w
         YluGrLM8EiWGd78S2px8uefzy3lAXmVRPTCbyR1tDvM47y8cL+ivmFNGmJpt2zk2zOh7
         kjp+eLoaErgyDOBaUlf7lA8OqnKF88mJMrtjlJDWGKLGpqDit49WmDlsCPDTfIZuer61
         tEWg==
X-Forwarded-Encrypted: i=1; AJvYcCUIoviSA7iQWHWmImWf3KmXnHGvV0f5hAvDGE/4arlDZgTtYtjhdeNTNylH10b3THeE6U7KF24BL6kZtxW17Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVymOyfasbEgPtgg2C5uRkKRMzW9M1Zx+RvTYYDG99WYWpV0jc
	HTaUyDoN6BEt8b2kDtaHKA1J9a6/si4ekdY9ijDf7Sj/L61USvkkObPr
X-Gm-Gg: AY/fxX6ipjAQrO57dWizbzSmjiex+G5/+6fEti52PJJzPUiqiGFlK17xnaFy2alcnb7
	4g/O5kRQWXpQNfLxJxG3ol/540QQJJwRgceO9h3Z1tapgeJk5wb7UjpxyBSlke9bP2nt9X1BiRo
	hvyaDxitz0WhwoR6EtmQqWvrmIZ6qUsTR1DkHD//DynFCIuVKH5Nw/UuF+iBAp42Ellzqbjasry
	dPf/4f1JVpIGLXA2RzPwwV+TauNZ9JonFnwvukF4nal6LHx7QMhEYG3lrMEF7epe4ioWiDuxObH
	7px/vtJhreVnfdiF4RbNkjI8RDT6EvyBTWJq9iA0bEl84XhnZcBkaEjY0DGexZTQwG5vhhnAg1m
	msKgB20RWGoQcCAMoVXDe3KQDUzWxmtGOlIT9JDX9TUKqGbBcyd4ZaC8GCS4aC2Jqykak7U6NLA
	b0Tdv0ZPwXIg==
X-Google-Smtp-Source: AGHT+IG7buq9CzX9ZRTrAw60UgkpwZAGNd7i/rZuf8pczHAcg2auSyZzQR/xxashE4pdHuR2UKZuqQ==
X-Received: by 2002:a17:902:da8d:b0:2a2:f2a5:4136 with SMTP id d9443c01a7336-2a3ee45b2f6mr207785705ad.22.1768313642789;
        Tue, 13 Jan 2026 06:14:02 -0800 (PST)
Received: from ArchLinux ([45.113.100.103])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a3e3cd495dsm205884225ad.96.2026.01.13.06.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:14:02 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Biswapriyo Nath <nathbappai@gmail.com>,
	barnabas.czeman@mainlining.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gabriel Gonzales <semfault@disroot.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	linux@mainlining.org
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Fix reserved gpio ranges
Date: Tue, 13 Jan 2026 14:13:36 +0000
Message-ID: <20260113141342.11057-1-nathbappai@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <e4f9cdc4-1b3a-44b0-83f1-315c934985ba@oss.qualcomm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Jan 2026 10:45:02 +0100 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:

> I was referring to the NFC eSE (embedded Secure Element) which usually
> has a separate connection to the SoC

Yes, gpio 0-4 are connected to NFC eSE and gpio 30-34 are for
fingerprint scanner. Here is the list of reserved gpio and their
functions according to the device's schematic.

0 - ESE_SPI_MISO
1 - ESE_SPI_MOSI
2 - ESE_SPI_SCLK
3 - ESE_SPI_CS_N

30 - FP_SPI_MISO
31 - FP_SPI_MOSI
32 - FP_SPI_SCLK
33 - FP_SPI_CS_N

Though Redmi Note 8 does not have NFC, kernel crashes if 0-4 gpios
are not reserved.

Tested-by: Biswapriyo Nath <nathbappai@gmail.com>

Thanks.
