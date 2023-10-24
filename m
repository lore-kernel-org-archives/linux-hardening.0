Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD23F4CA
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aLJOV/z2"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ADA10EC
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so4787649b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182351; x=1698787151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RD2uVI53YPOZ0BFcyzyDDbxRYlHoJPCjbTQOo+qzUU=;
        b=aLJOV/z21vV6m75Xb711cUpOEuqg9A1mLVfSpxFxZ2adW4XZGWqgdaI3E478R7lm6U
         t1oQVSIp/P9CpA/wQk75WxNjgLJMBBKTdWOdS9ZeHPK4DR5P77+CLdEMwq+HMg3TNHIV
         TQAQSqa47yQpwf1QTuhFJgUoWmvpyYZNStKfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182351; x=1698787151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RD2uVI53YPOZ0BFcyzyDDbxRYlHoJPCjbTQOo+qzUU=;
        b=Ryv7vOaG2lEEZk9P1jQ+FMRH5I0U8Ncpo1ICFUsmGuvVhBz80EqumUwHPYdft491nj
         i+A+ZssAR+0z43kdbtCv3nv93s2oIG9Fguso9Aj5ASgCHzTimBzhvTO06u+qhtyDEU0q
         M57InPG3QXY17sl7DdfWrcIKSWLla+tQ6dsDgKEyWxLj16ujdnyblSXf3AUFZnppIcf3
         bUlLq7JQMRVDcW8wjVXwInV96xihlj+oW2q+HAzklh6hcMN/vYEmEzmBh5EBtu6h/ySB
         OFme1f/bhXog/eaJImaGz8VGSIsH3wjauBQpj8xqr6ER8HPRM0AtGKRe+K0oK7Eht8jf
         lxUQ==
X-Gm-Message-State: AOJu0YyxqnESLux+BTY0pbocpGbi6aNaxw7m/0bDiInqdtNycg/Qo9ri
	58z7Sk6Te2paoi9TfVNWoQfYhg==
X-Google-Smtp-Source: AGHT+IFcgXtxN9yXCD1cRuZKX+QfDb7rz5xndfW1LoenNoqJDKgyBK7puzWMqXXuIIqdxoUPZgtJLQ==
X-Received: by 2002:a05:6a21:338b:b0:16c:b580:2a03 with SMTP id yy11-20020a056a21338b00b0016cb5802a03mr4592125pzb.24.1698182351538;
        Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t3-20020a6564c3000000b005ac384b71cbsm6440046pgv.60.2023.10.24.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] hwmon: (acpi_power_meter) replace open-coded kmemdup_nul
Date: Tue, 24 Oct 2023 14:18:53 -0700
Message-Id: <169818232967.2100071.14037828991402814804.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926-strncpy-drivers-hwmon-acpi_power_meter-c-v5-1-3fc31a9daf99@google.com>
References: <20230926-strncpy-drivers-hwmon-acpi_power_meter-c-v5-1-3fc31a9daf99@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 26 Sep 2023 06:59:15 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which has
> more obvious behavior and is less error prone.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] hwmon: (acpi_power_meter) replace open-coded kmemdup_nul
      https://git.kernel.org/kees/c/9cca73d7b4bf

Take care,

-- 
Kees Cook

