Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8A3FB09
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 23:44:13 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F6AF
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 16:44:11 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59bbdb435bfso18607917b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 16:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696376651; x=1696981451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4manyg4jn+tfLYFok6RJE4vtrYhKXlkYtdCzoyuohU=;
        b=TmAyl1n/eNsZtKfURDuoL2gUaXRF+rJFXEaqCV1I72bWyHKFuW2oHz/2rgauQL8BrG
         8Vlhf9tgFn0MzonSCIdAK6qZDxR8I4slUj9+e5Cp5HZRDBYzWgT8osKyCAos/zJze+Ea
         jdBcMZjeROboH62HT5TehThLdfw78X2N6Nfw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376651; x=1696981451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4manyg4jn+tfLYFok6RJE4vtrYhKXlkYtdCzoyuohU=;
        b=kFOj3AlhJUxF3UOgl5ykMHdubWHtkpqQotDBlRLqpM/EPfKDPiYGpxHw1yw3NirQyC
         SJJeuryw/WgYW/VOB3E1AG4b1ckCADGCqN1u57yu0RYiTpb4aGwk6JkZMrrA/W5BI5Nc
         VfMTwrnZ4QlpiC+NeWoblVnXyUao+ZRj3rqNWMAj0VYqWwAj3Izz4Sd1roKS9yRrbDlI
         lXRcOEa+Auo8q4f8chvkL5b95WoOwY71MWpD1pGwI5fPUaD506ulqfHFyTg7Qevd30Lz
         idFtJiwewZyaVN/SNOwiT0yvi22S2CwD98m8B4iedmNj8Gq5dTOOPHDsCS2ixfIEnrE3
         gWtA==
X-Gm-Message-State: AOJu0Yw1IVJ2ffzcUB5s0Qbs9HYsuIqbMR1yUTKN1OvA8kIG5HfepVPn
	YZdG4XVss8gBkCaAmk17lxkMyA==
X-Google-Smtp-Source: AGHT+IHPKf7qkMfv0ykTP8tZbmRCmQF77ozLScEX2ILIqdPv0U+kgh2tvOnmYsnzTfp8OGZxvKtt7A==
X-Received: by 2002:a05:6902:920:b0:d74:6c43:f32e with SMTP id bu32-20020a056902092000b00d746c43f32emr655844ybb.3.1696376651180;
        Tue, 03 Oct 2023 16:44:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q20-20020a656a94000000b00553dcfc2179sm1735207pgu.52.2023.10.03.16.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:44:10 -0700 (PDT)
Date: Tue, 3 Oct 2023 16:44:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] x86/tdx: replace deprecated strncpy with strtomem_pad
Message-ID: <202310031642.E858E955B2@keescook>
References: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 09:54:59PM +0000, Justin Stitt wrote:
> strncpy works perfectly here in all cases, however, it is deprecated and
> as such we should prefer more robust and less ambiguous string apis.
> 
> Let's use `strtomem_pad` as this matches the functionality of `strncpy`
> and is _not_ deprecated.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for respinning this! And yeah, I'd agree the comment probably
should stay.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
