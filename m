Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06291DA2C
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 16:49:14 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2502FA7
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 09:49:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c60a514f3aso117505825ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 02 Oct 2023 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265352; x=1696870152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7XJ5dqJNV5CR1Ji4WUBRRsOzTxjBAVuiqQFOAjz294=;
        b=E8qQgqeUla7Z+Sv3I6z+DXWD8CATV7TWihdR5WJYkycIYg9MH72uJkAua1tD8ySbBG
         Zj3KoLdyI5jEVh5Y3iYLpKdU8Tr1CVwzgeI2B8fuGvwx1knWXx7AqOSm2UFvFv//XsOt
         BEfpbh7dXt4GSwjIqmCKxcmDjmJ3rEdJ+TaJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265352; x=1696870152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7XJ5dqJNV5CR1Ji4WUBRRsOzTxjBAVuiqQFOAjz294=;
        b=FJcmrdn2kv8iy6wZrsKQKdy2VRlkuPqc/qu4D9zg9cWikMx+5ZORexI6mZw870N/9v
         UzPsZfDbMX+uth572D6BsEVBanQut2bf929RhY1mfWhRBl96UcOvahaufxM2OH/2D9of
         AUKyxY0V87xZscPkorDb3dnAcTFtbWJKPr7tLeY4n2LvCEfB1TIXTQf9bURelmYeixnv
         l5aBmMFFKfDRILk7OTFw9iFrFmqPD6IE2lFLdbk5AOwdVq1UXAzvPkRDTniuwGCE3XAE
         grCVTbMbWB/79/UO8Okd912x+VZqRlZGKRqJB0lkTs/LUIb3RhYntSdVwNZGpNkr2zmG
         mbBw==
X-Gm-Message-State: AOJu0YyaL/JyBNwMXGwTv7O7DMk++P1sOmX7SoLJLAvSQjblh/lsc9QH
	5YrVKtO/YQ34HlEuuRwCemc0Zg==
X-Google-Smtp-Source: AGHT+IHrv23LVD12gIvMlECOZzW2oxgMdBZp+C3BsK92+u/yOg4JgdFuJ1c1G1mAfbhW7PBrvKLhkg==
X-Received: by 2002:a17:903:2788:b0:1c1:e380:b128 with SMTP id jw8-20020a170903278800b001c1e380b128mr11306748plb.60.1696265352674;
        Mon, 02 Oct 2023 09:49:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001c63429fa89sm12200145pll.247.2023.10.02.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:49:11 -0700 (PDT)
Date: Mon, 2 Oct 2023 09:49:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Use size_add() in call
 to struct_size()
Message-ID: <202310020948.DEFCF4F@keescook>
References: <ZQSr15AYJpDpipg6@work>
 <169625984488.65718.9772394979337795498.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169625984488.65718.9772394979337795498.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 04:17:24PM +0100, Mark Brown wrote:
> On Fri, 15 Sep 2023 13:09:11 -0600, Gustavo A. R. Silva wrote:
> > If, for any reason, the open-coded arithmetic causes a wraparound,
> > the protection that `struct_size()` adds against potential integer
> > overflows is defeated. Fix this by hardening call to `struct_size()`
> > with `size_add()`.
> > 
> > 
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
>       commit: 3746284c233d5cf5f456400e61cd4a46a69c6e8c

Thanks! I've dropped it from my tree.

-Kees

-- 
Kees Cook
