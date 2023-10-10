Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6BC35518
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EBH9NEEA"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A959D
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:51:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso5687335ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696978287; x=1697583087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubmSWqN4/oZllpUx9ALydSh0+D44g/WNY6GMZGog46U=;
        b=EBH9NEEA8EE5LFojIFp3SBe11Rw4H5/IkJ3Ub+81fEPvHifX2B6Z52hZwmR3BedT0x
         rRqZYSerhF4YBiXmSLt6RF6a2GjRiUcmgBE995B/BaSGMeNbqr1cbns0UJndxMsr4eXh
         nUlpujl9q/oMlglA35FpUNHgWLQNTmGXkXtNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978287; x=1697583087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubmSWqN4/oZllpUx9ALydSh0+D44g/WNY6GMZGog46U=;
        b=fNaZoAyN//o8GBHZKLPWFGkk06HK6Q2SQ0IBMiGGlwegkJcmKhOVMcFRtWddXHET3N
         uDxDTskFrOHLvyjvVCqYB/fsXxzBqfBsGrrhxEAv1eGzSC3dCZeqVP/5/RyurLGHXFYH
         PvE6hkGPIMrpw5o96hDIfZ9Lt9QjZ2MK+vBYA3SuGKb3y1zpHjV+0i2K6Rl2zl5NNW/n
         JTJ+s77IlnWGFokFm6j3hwOs44Xs0NtNrHsSelBKYywFaPzBhDlfc2TlIeYYnM8zQZjm
         yO//YoGvCiIiTMm2hoaXbZvZL6lqld15kwwHlc1YaXGgSSURSQD5s2pt0PKdRE/cVFj3
         y3dw==
X-Gm-Message-State: AOJu0YyKpmzNaZTHnIAgRwJrBjt4QQgZ88s0TS1l2VjUPreGB6fCMAAU
	mmyP8pozQ4wW1btvoRemyF2t4g==
X-Google-Smtp-Source: AGHT+IGy+/NzfRV3ud+i8e03ChCZFw5EN81pR1ltghJlrE4aP8IIfdWDbQLD3eDks1ZvJ8So6yMflQ==
X-Received: by 2002:a17:903:2445:b0:1c7:74a2:5b56 with SMTP id l5-20020a170903244500b001c774a25b56mr20177500pls.43.1696978287254;
        Tue, 10 Oct 2023 15:51:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b001c3be750900sm12325562plc.163.2023.10.10.15.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:51:26 -0700 (PDT)
Date: Tue, 10 Oct 2023 15:51:23 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Dany Madden <danymadden@us.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ibmvnic: replace deprecated strncpy with strscpy
Message-ID: <202310101551.DAE933A@keescook>
References: <20231009-strncpy-drivers-net-ethernet-ibm-ibmvnic-c-v1-1-712866f16754@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-ibm-ibmvnic-c-v1-1-712866f16754@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 11:19:57PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required as the buffer is already memset to 0:
> |       memset(adapter->fw_version, 0, 32);
> 
> Note that another usage of strscpy exists on the same buffer:
> |       strscpy((char *)adapter->fw_version, "N/A", sizeof(adapter->fw_version));
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks, this looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
