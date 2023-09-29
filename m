Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555478F70
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 18:43:08 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2161A8
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:43:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c735473d1aso21215155ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696012986; x=1696617786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SKmWQamCrtcixsJKT7MUrX2kj878IQ12Ed2N4hWoOk=;
        b=g/mIIWsaRxUGnn5Oj+K9YynrHc6YDKNScDmyu1hQorVmOhOL7Fd4Opmk8biEIwCtrw
         1egrO7NqJnt+fBFkDRKw43NnZ9e0LPlS7WeF9FINsv5S4KMAzPI1BP4U6ypSzbbnq8IC
         zkj3/BD6z5S6AxXAPLbEEnA/kH7d7L2nsdemo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696012986; x=1696617786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SKmWQamCrtcixsJKT7MUrX2kj878IQ12Ed2N4hWoOk=;
        b=H34pLiZwvfAYmiLEtkEctlHuTysTHJqDvp9776EzxuL+YsQawBZf6rRzCCNXP0QgaH
         XeCdCHeutQmL21SW4NoWSGR5G2ryWwATie48Ko8Oqz+Bv0zp2L4Li+QPk93KQgeMRAyv
         rVASiz47Q6hMpob1WJHgLOuK0nFrWuoH539EHoF/R+/fsprMVJ1najw7w3bpa5+mUnGa
         XtLsTQa3XWm7yHQYNMpsRoYum6hXvNCoCEYZ/XcmHEUaxDA5IsUjVMncUtKr/UE0RIbX
         ZwjKpHzrBm3KpZckoW12D44GrnNGxOm2yEYfnKNJPpXpZ6qtmWvzUXRqdN2FBkzXYnAN
         vRiA==
X-Gm-Message-State: AOJu0Yyfy4wOTLW0WbvW7TGvOEjCEdXcAZwYD5msg+VlKDZ3Wl8vrjFw
	HC3DDsC48dCky4Nhh3U2ykxaEQ==
X-Google-Smtp-Source: AGHT+IEsqB2xr3YnyNH2vhAdObEENgjLSpzITFNT2h3b7EvGsi8I2wkdjDwREM73j5bMAdEe3ejG6w==
X-Received: by 2002:a17:902:ed44:b0:1c3:83e2:d0c6 with SMTP id y4-20020a170902ed4400b001c383e2d0c6mr4265781plb.52.1696012986336;
        Fri, 29 Sep 2023 11:43:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001c631236505sm7616465plg.228.2023.09.29.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:43:05 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: refactor deprecated strncpy
Date: Fri, 29 Sep 2023 11:43:04 -0700
Message-Id: <169601298358.3009007.4356114929314490764.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912-strncpy-drivers-bus-fsl-mc-dprc-c-v1-1-cdb56aa3f4f4@google.com>
References: <20230912-strncpy-drivers-bus-fsl-mc-dprc-c-v1-1-cdb56aa3f4f4@google.com>
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

On Tue, 12 Sep 2023 22:52:04 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We need to prefer more robust and less ambiguous string interfaces.
> 
> `obj_desc->(type|label)` are expected to be NUL-terminated strings as
> per "include/linux/fsl/mc.h +143"
> | ...
> |  * struct fsl_mc_obj_desc - Object descriptor
> |  * @type: Type of object: NULL terminated string
> | ...
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] bus: fsl-mc: refactor deprecated strncpy
      https://git.kernel.org/kees/c/fafafc55eb30

Take care,

-- 
Kees Cook

