Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1BA199B2
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 17:39:49 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF698AC
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 10:39:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fb85afef4so24302b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 02 Oct 2023 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696268387; x=1696873187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TpVKVfOllcQbS/ZFFzm5rvtMjeszAGVS8sUGlEYlZ2I=;
        b=jJGgYRZMWi7/h+uboTMzxc2yPPkE10cMGTYVEXhsFt2bC1/qav9/U/CeayDNt866bJ
         7wxKkpEModSLt2jVVYbuP5HLYH5itIzjpPcY2/CELldUwMheB66irN3MoodZS14uGciM
         1La40tt6mBl/BuoiFFqXPUllNVzhGdoWjwc0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268387; x=1696873187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpVKVfOllcQbS/ZFFzm5rvtMjeszAGVS8sUGlEYlZ2I=;
        b=eV1bcdlZKE90Iub9ebHp0V214ttNWM8i8WAU3IMhVo+grDRYxxX3c0QF1ku2rVxDAg
         MK0Gjy1f9TXKiKoVuYCCMUkP/Uo6wrqAYjXEO9x4iSPwzgtuiA8CqVh4NzQOxsVGVir6
         uUHToWjQ16D6b65cN+4vFaXale8AgpQYv9r3LEKKjzHg5HJdPjJlS75HWKTUBBfxr260
         54N3aGYlcoeDCBLEpkNB+fY0ukGykBXOP9sYM7eQ1bbe392EI+7tSfsCliNIXH98GnAM
         5yfIll7alfPPsonUB6usZSxB/iVKgqH+Gat2Q9CQhHWfuxsgBWNvhihYc3zL9eQ9E7xU
         NC0Q==
X-Gm-Message-State: AOJu0Yyr4osdPQOsHF1UeFdzKbhTY+yn8GVsfFjFUHDp5Pf0tpzDWJOD
	piXl3Dzg/csqVUvqn6zsuE/gQA==
X-Google-Smtp-Source: AGHT+IFPixOT7PLEvjE3i0KA0O/A27DOjo/GqhKHxqOgkmL+NKkqUCM4OONVLUct28kbISv0eENneQ==
X-Received: by 2002:a05:6a20:948c:b0:157:7568:6796 with SMTP id hs12-20020a056a20948c00b0015775686796mr9204380pzb.60.1696268386709;
        Mon, 02 Oct 2023 10:39:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ee8600b001c55db80b14sm6404674pld.221.2023.10.02.10.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:39:46 -0700 (PDT)
Date: Mon, 2 Oct 2023 10:39:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] hwmon: (acpi_power_meter) replace open-coded
 kmemdup_nul
Message-ID: <202310021039.C13E217@keescook>
References: <20230926-strncpy-drivers-hwmon-acpi_power_meter-c-v5-1-3fc31a9daf99@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926-strncpy-drivers-hwmon-acpi_power_meter-c-v5-1-3fc31a9daf99@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 06:59:15AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which has
> more obvious behavior and is less error prone.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for continue to rev this change. This looks much nicer, is more
readable, etc. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
