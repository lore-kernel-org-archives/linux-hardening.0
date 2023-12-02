Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ahpW2z93"
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD8D118
	for <linux-hardening@vger.kernel.org>; Sat,  2 Dec 2023 12:47:49 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ce3084c2d1so15741445ad.3
        for <linux-hardening@vger.kernel.org>; Sat, 02 Dec 2023 12:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701550068; x=1702154868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0aqSqPWlKb+jtA5F4LHMBcDnLf0J9EYiCL05v23tWA=;
        b=ahpW2z937uml6d/hTclPjdHURiaY4371JoD6Lvw0+yPtFAgoqovyg+qJItXhRZ+Ygw
         IRz+Wt+uSxJS5D5UlBNGQLpMu7vAI7Q3mQYYSeVjl52c9Ea0DH9a+1lcxe1hKhLgPP7p
         V3ZbAV5KnHIr4b3E7Q+Ho3bp94bfiANocTwMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701550068; x=1702154868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0aqSqPWlKb+jtA5F4LHMBcDnLf0J9EYiCL05v23tWA=;
        b=B0ujx+xeeC0J/5ihnuQ34jDO8LTE5JD5Wdm7cf/jk8BSwBH6FFs3rARUK3vlkrAEhg
         r1CaTeGT+T++7mzV8RJIdve1+4JDzUJo6fDDJk7e0299uCvtQOU4GnOSXYLbTl+HgqU+
         YI0FMnOSoklBPmIlOI8nPUcMYkIC5PGHCUVHP0s3uqNzX8ELpvT3IoKuaMy6Xm6wQL+z
         pTJfMRgnRWmMlpqAKup8Exey/+D+BQF/WC3garh7S+DLbaiAUD80i9CdpHnI7Jxo2b/0
         wUUPlMRuzmPazidr5xfrY78KMHrGounqOve7rVVuvxjNJbwqmErsPHbRoHH6bwIu2K2R
         Yd8Q==
X-Gm-Message-State: AOJu0YyZDZL2mMNJzzXInJbgnyWV9ftQobTA6UKSt5lkiJs/ndf5mw8v
	HR1onvw6VGIWeKTPott3y13lKg==
X-Google-Smtp-Source: AGHT+IHgbtAlw9VJor5JJ08NkYdAzGvkAbo2d//Fi6pmcG1MfGXvH6uWcg+3/k82YL+iZ/Qnx91FiA==
X-Received: by 2002:a17:902:ca05:b0:1d0:8761:4c45 with SMTP id w5-20020a170902ca0500b001d087614c45mr263770pld.2.1701550068537;
        Sat, 02 Dec 2023 12:47:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cfc42ccfcasm3873136pld.152.2023.12.02.12.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 12:47:47 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()
Date: Sat,  2 Dec 2023 12:47:23 -0800
Message-Id: <170155004188.180877.9632245955503394490.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105202936.25694-1-s.shtylyov@omp.ru>
References: <20231105202936.25694-1-s.shtylyov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 05 Nov 2023 23:29:36 +0300, Sergey Shtylyov wrote:
> In persistent_ram_init_ecc(), on 64-bit arches DIV_ROUND_UP() will return
> 64-bit value since persistent_ram_zone::buffer_size has type size_t which
> is derived from the 64-bit *unsigned long*, while the ecc_blocks variable
> this value gets assigned to has (always 32-bit) *int* type.  Even if that
> value fits into *int* type, an overflow is still possible when calculating
> the size_t typed ecc_total variable further below since there's no cast to
> any 64-bit type before multiplication.  Declaring the ecc_blocks variable
> as *unsigned long* should fix this mess...
> 
> [...]

I changed this from unsigned long to size_t, which will do the same thing.

Applied to for-linus/pstore, thanks!

[1/1] pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()
      https://git.kernel.org/kees/c/c92116e01d32

Take care,

-- 
Kees Cook

