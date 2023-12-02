Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SanzOGBp"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231B7118
	for <linux-hardening@vger.kernel.org>; Sat,  2 Dec 2023 12:32:28 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d07aaba357so3936825ad.2
        for <linux-hardening@vger.kernel.org>; Sat, 02 Dec 2023 12:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701549147; x=1702153947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIRYAecgaHbUJDf55/ejmjsQC15v1f8iGHg4Qn4ZBz4=;
        b=SanzOGBpwNTC6VTLCh69gALRlSulW1/AN7r4ENlVvQmD2TezbsfYMkNzSgwHBr7Q+J
         bW+LgZ577/nJWRTLi1OFtdTSb6IMcGZM+O4XSbQ6Mu1olyeTm3EgDetuwgcX1/SVlug+
         jnt1j1u61fogU7WIEE2qoyjo2iivUc7ib5h+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701549147; x=1702153947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIRYAecgaHbUJDf55/ejmjsQC15v1f8iGHg4Qn4ZBz4=;
        b=pRP0738L9yg8G7PxhbizICHvgRaqihiVTlW42akCHPTpaYTlw8nmGVThp/z3f31DBR
         iZoPltdklv5R0F93DSgI6clEVh7miSiP02Uv4ZIrvSV7LqDKFIvm6tweCa9C2MstMqPT
         WXpkuxRLXyKtIdZlEwwAkUV3ZbZuLoztqrK4BPUgTfCDATaLfNTPZqRLmR93CYdIdpqE
         qLfivl/M2PvdeBiFGxtiFAlcNCe0ghNDc6j8rMAr+o/uRMBusEv4ohSzxuU8D9hbDUk/
         KJ9pDqxtiFOBX3GQZsGOFraaZ5Zez6BIle+OmomUe90uuhMYs12t7xznBKZMyQFIs2No
         igJw==
X-Gm-Message-State: AOJu0Yy81G0b2N3ovBpjnwmJOd5r/FS6cxhYnnXAf8fkIr5aEg0c0ISt
	AynFyF2JZsOt92DG9kGlMj+tcObnKRTZXcPoLW4=
X-Google-Smtp-Source: AGHT+IEY6utxOUbDKc+di3tmLd74oi8V97niSTk0Xt6LAXsff7fKHxfMr75/hRpID77r698HIGAC0w==
X-Received: by 2002:a17:903:11c4:b0:1cf:f3a0:3c8e with SMTP id q4-20020a17090311c400b001cff3a03c8emr1868973plh.28.1701549147645;
        Sat, 02 Dec 2023 12:32:27 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001d05efd8198sm3022690plf.197.2023.12.02.12.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 12:32:27 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Russell King <linux@armlinux.org.uk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] atags_proc: Add __counted_by for struct buffer and use struct_size()
Date: Sat,  2 Dec 2023 12:32:23 -0800
Message-Id: <170154914064.179444.11376018592445133931.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZSVHurzo/4aFQcT3@work>
References: <ZSVHurzo/4aFQcT3@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 10 Oct 2023 06:46:50 -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] atags_proc: Add __counted_by for struct buffer and use struct_size()
      https://git.kernel.org/kees/c/ac7110d883ff

Take care,

-- 
Kees Cook

