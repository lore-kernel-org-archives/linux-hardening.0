Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064663;
	b=GHR4b1JeoNTkwl3r3wie99qda4XNo9JN1QLJwF2Fbqr5S34ofz4s0PxARWEBjnpNYArS
	 vbUgx/mLbBL4RS47JMiLxEBTyZHXNjAHADkLjUXUV/HXnUG33QQvFOvFemxPN3d7jRkCG
	 //phlsTy2gb5G76arvHJn6A3FF7K1PJALyQY2Shm9vswoSibAGZDS8GZNmm80cwUwa3vG
	 3D9XQZveMOnyRlomGcnWjIbA2dPdOLxki1H5TzYyXTrbPwVGboyWBkSsXsNU+XV/cl6t/
	 E7U+t1XlE82K71/2rFLvFUFys0Vaz+n/ZTa0BwBYAwdD6xyUVm9pGLK4H90B8Db/qZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MeF/1bFkHYSuxzskpfZlny2NzE7wY2okieEwz4QfiGw=;
	b=XMMmIMji3tkhhPe7ND3Aa70fn+3M6L0D2pSli8fOMaWF6VlFtG4TTCzU3yHn83FVBoR2
	 gPz/XmVQiVH+3CGPQ+OD0lI06maAgQO0hvyACb3yJMRCKjXDCAsphGSlQVCKzAVo4TSa6
	 XcPtW7KZTZBvx9rIb9+H4XqfibwLZ6mh1vb2OMzYjzzWwTPc1tZVZDGeTcWeYzQWQ60H0
	 C5HiYaVqthhwhcHZrxoC0ozvKDzqrEpaPMKsvSmaFjm8AwQEchps4ulov0OXE+7+RGvXL
	 o/2fzG/hpF35ksP4Bi1qJFvibGpkzvKEluEdkw+d6C8R/tnRTI1eqLe3ONaFpfoyVGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mEx9JaoF;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84B6082BDB
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 15:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D84B6082BDB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mEx9JaoF
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab3b29a298so11456701fa.3
        for <linux-hardening@vger.kernel.org>; Sat, 07 Nov 2026 07:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794064661; x=1794669461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MeF/1bFkHYSuxzskpfZlny2NzE7wY2okieEwz4QfiGw=;
        b=mEx9JaoFVWqn81xBnARZosOA2nexoirrYwD4tcRgXFTI4v7vXnV8xXRdGkhzNYK9Fn
         BdI46ZJRyvh0BagG3hjda4IwH4W6CrhfIlmg52m/q9Is79OjTCAneo2dGtS/537dvkI4
         xLJrZbGfBZ6oUR2eCZRxRnzUyNfnhx70JiVyxXo7tDb1Qcoir0tEvY5RETs/UGFVn00j
         8l50nzCYoNt5jBeKeDeoqM2YiMxcsy/8EuDCf3f5Ewybi2OkpSxoLHAQ66RM+2Jz2XU5
         sGajPlZRf9VswyfQkzPoMlkaJun1HnoA9UwDJgfcbmyIQEeQeDLukm0C8630NrppMLGO
         3Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794064661; x=1794669461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MeF/1bFkHYSuxzskpfZlny2NzE7wY2okieEwz4QfiGw=;
        b=EDyQUiDC7/brg8JCnFcewk1/x0AuR1rqKUivprSVhDZkWZeGmT46SblzjIfM6WNh/F
         yO/Cmdt4yrhjqcx44kMrXfWL2Qnx0uKp0odXZ/OLjkDgjmzaWRZPunXciHxJqzDmzBu5
         o7hnahNDPaQXGFkxsStKU+/vWucO4ILNXzGdHDptSHYr1Ldn0hZD4VOFvpG/sYqDj9YE
         GRe9iGy7kofkJl2IH+HRzi4dFoj2isxPoXR1VJx5mTFbA8vsBUtojJ3535E7ntRZnC77
         LwWnFaTTgeczoN0vxB7qCYSwvLo7uW7vizpy2I5biy6pZQWH1pSLEppYeGzwdD8vEKwx
         zEBQ==
X-Forwarded-Encrypted: i=1; AL+hErHlu/PmuPxIiskfpQA2BJLyTBWIZy3VftTOugKmCZu7dduwVXESDSCIOWikKKGHdWF9kb0n1eK3grdMd4MXb10=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WMVAqPw4CMTNbJaVs3rb61UFJyWMdXcVG7ALufCzMz7pLKNhx
	Hg8jxlaeOJ6TgAwG/43Hn2gFHE8nljkcd7zoCeGpfyFbRKyg9k63RsMa
X-Gm-Gg: AYBFou3Z553fD0nilthuOex7Y9HLRr3Oak1XY5qHxGyjiRYw/BDN8485Q72ib4Sp+5F
	FjBCJUYbIupdagLX84+hhvT9YPfirinxQ4qtpKMYNUpcV7YmFg54in1VCSuexvl2HKyKmpmUYpy
	iRzmN+fXFa3u7FRMN3wuT1SQ92LIMHN8dIBHcCD3UaqyvfOUrYdIY26PmRlAgA6YXWXfoHBILCy
	bLGZ+sZ4nN5ncNUCERqdN/7yXB26aVoKAElx87UmeX266wkl4tNjJ3WWNUmFsrQMSc1w1UYEXn6
	4f9BqLYd/GralMz1W0WJuA7bYF0abmVEY5KZm90wT4+jGFg2HYXdKLxmIPXBScWcHWsUs893y74
	rbwIudbswCaW6jDfts8vr1l4qYUP2yE7Lb82YvHZAQtKlZgMwPfAkRelVv54/6KByYJicGFL/qX
	QaWfFUlQPkD/fbvCcjz30BIOAL4ZT1FRN1SZrMSjacj5bfQVdhywq97emRT+26ZgDbTLs8sMqVz
	l22V+wL6+IaFZZMbyMeR291mQZCqdhWpCx3buof8RDXH5Y2XNPFSWIx03CQkst6sxL/JrkUdfrn
	9jcwuynq9QIQ108vurZ9rifHn+HqLyvFSeWERuIdPq0=
X-Received: by 2002:a2e:a542:0:b0:3ac:41ca:1104 with SMTP id 38308e7fff4ca-3acf36e890bmr11461021fa.0.1794064660640;
        Sat, 07 Nov 2026 07:17:40 -0800 (PST)
Received: from thinkpad ([92.36.72.88])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ad976a9911sm1616151fa.38.2026.11.07.07.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:17:38 -0800 (PST)
From: Andrey Zakharov <dedemorow@gmail.com>
To: x86@kernel.org
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86/ioperm: boot-time switch to disable iopl()/ioperm()?
Date: Sat,  7 Nov 2026 18:17:24 +0300
Message-ID: <20261107151724.74703-1-dedemorow@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027220904.15896-1-dedemorow@gmail.com>
References: <20261027220904.15896-1-dedemorow@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sorry to bother you again. I was just wondering whether anyone has had
a chance to look at the question above. No rush at all.

I would be glad to help if a boot parameter for iopl()/ioperm() is
useful, and I am equally happy to leave it alone if it is not. Any
hint is welcome, even a short "not needed".

Thanks,
Andrey
