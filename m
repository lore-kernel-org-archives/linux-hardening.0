Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C24388
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 04:52:26 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11CFBF
	for <linux-hardening@vger.kernel.org>; Sun,  1 Oct 2023 21:52:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5db4925f9so18643615ad.1
        for <linux-hardening@vger.kernel.org>; Sun, 01 Oct 2023 21:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696222344; x=1696827144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgZc1gl8r9gpj8F7Au1ygxE46XZZIEmRRHjiEVQPVBA=;
        b=TL+HoLMvWBDopW0IXzRldKSynFlSpTg0Bg1mJ4trFQJilvADyqdIfpRRV0VZlwLXh7
         Sc3dCxRRCOZNIcawLY8aBmEyTDR2cFz2FbiIyc6/IMFfBa4+V6f9HlTQog0wfwISkkfI
         iZc749P+OsQk+I8lQnLhnH63D7kTF5iSkptB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696222344; x=1696827144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgZc1gl8r9gpj8F7Au1ygxE46XZZIEmRRHjiEVQPVBA=;
        b=CKpv9/NxWd7siU+exIe3v6ZVvRYyNgdXAa0bB/UKjjVcQ/A+bO2pBnfFD1PZh6ovXI
         BqVce0ydG/xY2+GfTnRU9W9AF7uM8nh2X0vWr8TtGzZCcljhNaFiWbIABBxQ9eUl7zsm
         mtvrQnsluigaH6a6S1va/i6K+Nn2XggzLrp2ELAlqr703pexZdrpun5MBY4Fi8e78rDt
         vo14hG1zsFbweKpkG8oyujbn2Vjw6Selu7z1cvN9vjLoZ7f4tQyfzfWQkufa3MEdXMX0
         n5vWser/QoLVrOzL/E9MScLcAXsMwg686RGwH2KuKBAgsjoTSVzrCO2CY786g2T4FoAs
         qH/w==
X-Gm-Message-State: AOJu0Yw0j5n2gs2Nq68xC6841y2aQdQCQf+y3DE9xQWpR1PwcNTwrteQ
	pbYTyeNernwLrC4ujWHUssoGEQ==
X-Google-Smtp-Source: AGHT+IEoCHeBBwDUL5/duEukBlE8ayroCrMSrtJAST1F9vN+5909TzVhFCg4Lq92qLJoTTJZW7Qzsg==
X-Received: by 2002:a17:902:e54a:b0:1c5:6f4d:d6dd with SMTP id n10-20020a170902e54a00b001c56f4dd6ddmr18858004plf.24.1696222344309;
        Sun, 01 Oct 2023 21:52:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d31200b001b03a1a3151sm9883404plc.70.2023.10.01.21.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 21:52:23 -0700 (PDT)
Date: Sun, 1 Oct 2023 21:52:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brian Foster <bfoster@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 df964ce9ef9fea10cf131bf6bad8658fde7956f6
Message-ID: <202310012150.72AAB06FAD@keescook>
References: <202309301308.d22sJdaF-lkp@intel.com>
 <202309301403.82201B0A@keescook>
 <20231002032239.t7ghpigbq5jy3ng7@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002032239.t7ghpigbq5jy3ng7@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 01, 2023 at 11:22:39PM -0400, Kent Overstreet wrote:
> I'm not leaping at the chance to reorganize my fundamental data
> structures for this.

Yeah, understood. Thanks for taking a look at it!

> Can we get such an escape hatch?

Sure, please use unsafe_memcpy(), and include a comment on how the sizing
has been bounds checked, etc.

-- 
Kees Cook
