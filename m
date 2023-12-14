Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZkSvzWFe"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453D810F
	for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 08:15:05 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0aaa979f0so48788745ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702570505; x=1703175305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1Ou2BN/NSSGCNvRe4VvolyrUm7oUAf2oh76V3K9T9M=;
        b=ZkSvzWFe4GfrTmBb8iUOsSMZShHZoC/6pFizlZJfB9ONOgN3UTUwkKgX7kuJyqDJbT
         kavajsdaTI6rnXuGy85d33h+u8VKloOrALanp91z+RAAw++psw1KGHgu8zFL0gR5oymo
         S2PjEMBmoHCB52+2P6XENFdmySM51D5bZWxYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570505; x=1703175305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1Ou2BN/NSSGCNvRe4VvolyrUm7oUAf2oh76V3K9T9M=;
        b=hvSS+HBWtERaNnY4oURoo7KgZ4Rx47UJJqhfBffhHtKrpYRvVzzAjzPFogV3TfnKa3
         zafdW1Qu+dWisYYtLWGT1Sj4Ya96pkqwOlQOiHEuo03QweV2yI3IKfHn9b5xN+e9Q9UP
         Vu/vHYHEmoFhHebVeJ2pRWMj20NidvCe6nWXLgQa80XDLJGvVu2SXTfSRLI7JU+ldDzZ
         PHxqET6t22LBqgX4Awnld0+AxOMxhNvBPbT4+muUp4kMdQnFAnl+b0vphyGTcm6Tdo0A
         zEOSG8eaXrMQFCSYaqAI3KytZ6uerPZ4QOMPB2nQhyx1XY++61ysPvTvYRFYCMwIbKo4
         YoIA==
X-Gm-Message-State: AOJu0YxqG9LZG7zTJYRajR2QbN708j8a3a4C0zBlVYh0QwXqMA/xHFml
	MyW0kiSlA9f8YrqPef/o14yAtg==
X-Google-Smtp-Source: AGHT+IH+ytQj5wa72LYKC5YIjqTselzMKodTANBeg8JotZhzXxmhWvXBDTQzTxLBsP0QwKZwCFxenA==
X-Received: by 2002:a17:902:eb82:b0:1d3:4c35:17a0 with SMTP id q2-20020a170902eb8200b001d34c3517a0mr1926746plg.120.1702570504783;
        Thu, 14 Dec 2023 08:15:04 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001d1cd7e4ad2sm12549781plf.125.2023.12.14.08.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:04 -0800 (PST)
Date: Thu, 14 Dec 2023 08:15:03 -0800
From: Kees Cook <keescook@chromium.org>
To: davidgow@google.com
Cc: Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 3/5] overflow: Replace fake root_device with
 kunit_device
Message-ID: <202312140814.314B59CD@keescook>
References: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
 <20231214-kunit_bus-v3-3-7e9a287d3048@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-kunit_bus-v3-3-7e9a287d3048@google.com>

On Thu, Dec 14, 2023 at 04:49:17PM +0800, davidgow@google.com wrote:
> Using struct root_device to create fake devices for tests is something
> of a hack. The new struct kunit_device is meant for this purpose, so use
> it instead.
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
