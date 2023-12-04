Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kZlZspSL"
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A321101
	for <linux-hardening@vger.kernel.org>; Mon,  4 Dec 2023 14:12:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cf7a8ab047so18423065ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 04 Dec 2023 14:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701727958; x=1702332758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z5w+w40k8reyqU3pjVynIeZmpGAhXy9mRn2YDUbDK6o=;
        b=kZlZspSLgzRFo2AIXtG6F/y5aA8ezGQOCsKYoHAcJ1v2zCpqJbuMDedfbiBy2Tu9C4
         xBMU8TyxnQa10i2a3GeTUsj8z8gBH5CsQc5+0e0MN03zF+Lw9pyPk9VdbFQ2ukoFbHyD
         BrYOBrSlcnLeWbKJmccJ3x7v8xeQbXe2+w3IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727958; x=1702332758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5w+w40k8reyqU3pjVynIeZmpGAhXy9mRn2YDUbDK6o=;
        b=nSJNjKJJRM15lKStvPCxWbxSevPMkmmGnFsTnuulY7UwljUUo9fJFR6hzGJZGUVi+x
         USdvb7bU5HIMiy/RKt8qJn0BgnvhkYtweLoMOhslNyQOFvpavg3T5sJWH1mOX8flG4xj
         kB5xWZsIS/72nqzkDIIWe2s9wuI64BQNlS1oZSC61SZE122XcT334N5+dBHsCFtjVKRs
         9V0JjM8ld1EjfcbVFzg40bV7g/1iOWWJJALhxvHT6fLbrYd2g0f5xZwY0FcrmZozAKaO
         23GxB3OqDr4Ew75bsjxb9WTPfdQhCnvRy2PwebXTp60n6WmrlBgf72Hv2L2JOmakHP1g
         YRWQ==
X-Gm-Message-State: AOJu0YxKDzdS7JhJY3vwADoHV55KG7Hq1qX28XP83vz1Qsr6LezmIeoH
	jhSvskjimBHdvtYCGUIDIOCccQ==
X-Google-Smtp-Source: AGHT+IHM5ek9ahZA4zDcV16QXDzsz49v7j1xdOQOO23qiKhgCK2UxX5VuXi5Txfj8ada4KvlaWZx7w==
X-Received: by 2002:a17:902:b210:b0:1d0:6ffd:8346 with SMTP id t16-20020a170902b21000b001d06ffd8346mr1942760plr.81.1701727957671;
        Mon, 04 Dec 2023 14:12:37 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b001cfc4d8eddesm8876332plg.180.2023.12.04.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:12:36 -0800 (PST)
Date: Mon, 4 Dec 2023 14:12:36 -0800
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Granados <j.granados@samsung.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/18] seccomp: constify ctl_table arguments of
 utility functions
Message-ID: <202312041412.7D0EAC47E@keescook>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-5-7a5060b11447@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204-const-sysctl-v2-5-7a5060b11447@weissschuh.net>

On Mon, Dec 04, 2023 at 08:52:18AM +0100, Thomas Weiﬂschuh wrote:
> In a future commit the proc_handlers themselves will change to
> "const struct ctl_table". As a preparation for that adapt the internal
> helpers.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
