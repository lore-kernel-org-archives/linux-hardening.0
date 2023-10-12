Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3A2941C
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bRTOFj4f"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729E3DD
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 09:48:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9a1762b43so10039235ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697129324; x=1697734124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zj94NuVMRyygdkOW8mvq9Nen4maWkMgZsmZqNR+8rw=;
        b=bRTOFj4fSA056yrQKskox7o7RyuI3GNwUJPIzG55g6Vb1Vj52nUkqQhnJo4fRkVQZp
         BQdiwdDAotjrg1oO3PqN4zr9BORHv9s5+pLpCKdN+IPZ2CV23Ab/nQujySzvosvML9TL
         jxeSSVnjvDrn1e+T0a7dc/Ii+mk2RpVKRd34I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129324; x=1697734124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zj94NuVMRyygdkOW8mvq9Nen4maWkMgZsmZqNR+8rw=;
        b=CPT2Unbe9B1i5RsvV0ZuyvZwXIFbGPBj3J2segA6DHmy01AiZHl3UzHczPpqQyzFyy
         YKTiJEuYne65N3/5pFiVOGF/0yLsKIMWsnacBB7ge9CyHIPLy4UrlDDh0TWY5/JYUhGL
         00wdzXsUHXWFqExjyKxy+1rqwUFyi0PbnNZk9IL19XhHhnMScSU5zKHAVZH+22p+PIQx
         Asqq50xBzZgtlo5krzAoEV3aK41GKY8P0K8pKLpEg0mSVmjC1ETPFwviVub+sE4yZggZ
         4N2q+CRn9gX3MGB5/M/CW2fHKysZhc1uNgzGczx1b6o97sFFabEz137kPxUl0zT//ZGP
         Ac8Q==
X-Gm-Message-State: AOJu0Yxk5ghGw3QxtJw0PI4KhgCV0ZoR5Sb0x+sLqo8I5MLmc1pHkNTw
	ttKvpRJ5br4X9f9eQyvj51UrZA==
X-Google-Smtp-Source: AGHT+IF831rt9uwN8FV+a7yFdX158syIhIfsDP9+BmIbnBUGEesMv6egJHZONGeGkhVAAiy8eu5gZw==
X-Received: by 2002:a17:903:11d2:b0:1c7:2697:ec0a with SMTP id q18-20020a17090311d200b001c72697ec0amr28084231plh.30.1697129323902;
        Thu, 12 Oct 2023 09:48:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001c5076ae6absm2204778plb.126.2023.10.12.09.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:48:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc: Kees Cook <keescook@chromium.org>,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pstore/platform: Add check for kstrdup
Date: Thu, 12 Oct 2023 09:48:41 -0700
Message-Id: <169712932001.5350.10182418867498473478.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623022706.32125-1-jiasheng@iscas.ac.cn>
References: <20230623022706.32125-1-jiasheng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 23 Jun 2023 10:27:06 +0800, Jiasheng Jiang wrote:
> Add check for the return value of kstrdup() and return the error
> if it fails in order to avoid NULL pointer dereference.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/platform: Add check for kstrdup
      https://git.kernel.org/kees/c/a19d48f7c5d5

Take care,

-- 
Kees Cook

