Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GiY1k/0d"
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5276C199A
	for <linux-hardening@vger.kernel.org>; Fri,  8 Dec 2023 09:23:02 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce33234fd7so1616559b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 08 Dec 2023 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702056182; x=1702660982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WNXDom1pGgFzD7z60+nX5wKE72JYAG4paS5sk2JCKg8=;
        b=GiY1k/0deCp31KIS/rscp6m71yTNYUEL+kB1zQ9qcDADBj76CBBvx96QLXr4UQf3Nf
         OYdJGf3XPP7YZoJg1Y2dC9/qVCN1IkX0g2Hy5/Ly98HxRGmVzHiV8Jv+CrND1k4IBlBo
         +AGAJa6nLkIv8JFMTzIl0elnYLMdooCku0EdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056182; x=1702660982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNXDom1pGgFzD7z60+nX5wKE72JYAG4paS5sk2JCKg8=;
        b=tfpOaG4EAjwboOwMjenFFFkd4ZX1G2KPsvM8kggTeXmmUkqfTN2qYt1/N+n8GtYvhJ
         749ruKb4oRnV3IbAMjb1/KpmnNG11Gn4ZjBnCfj82ybi32xjWz1pD9Q6D87DnrIb8EFB
         1KQM22SpNZG/o9oQQZcyAsa/zqOZWtTzsX9HGwUQeG3x+dhe3N2eoUGfjE4piBYMtEPk
         XceAqtKYEJu6vjIUgZUslPlafp6gmv9WFV0II3968vf+BhEaJs+C7Vdi9IbKOeIoLIOc
         Ew5lYJIPvWnu5IGrCZ4mG5o+/S4RdbJIG7pE4d9maJjhWF+fxjcQgrH1pMxrSvo+XYkZ
         +t6w==
X-Gm-Message-State: AOJu0YyaRhX+6JxeeCqMqyIjbYh2l+xdFXn3S2+AAOeGNa1dcS1uIk0G
	QiNPZK3X/gPZ8yDD/CGUfhkexA==
X-Google-Smtp-Source: AGHT+IF0odaLvAeilH7K2WI0rkMDi0C9smclmU3oIrDkxldyXyKpbjGkUJWAwcvrZUO929m23SwWqw==
X-Received: by 2002:a05:6a00:1a8f:b0:6ce:50b4:a21 with SMTP id e15-20020a056a001a8f00b006ce50b40a21mr321026pfv.27.1702056181771;
        Fri, 08 Dec 2023 09:23:01 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00098300b006ce7fb8f59csm1837731pfg.32.2023.12.08.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:23:00 -0800 (PST)
Date: Fri, 8 Dec 2023 09:22:55 -0800
From: Kees Cook <keescook@chromium.org>
To: justinstitt@google.com
Cc: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: ena: replace deprecated strncpy with strscpy
Message-ID: <202312080922.881A1515F3@keescook>
References: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>

On Thu, Dec 07, 2023 at 09:34:42PM +0000, justinstitt@google.com wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> host_info allocation is done in ena_com_allocate_host_info() via
> dma_alloc_coherent() and is not zero initialized by alloc_etherdev_mq().
> 
> However zero initialization of the destination doesn't matter in this case,
> because strscpy() guarantees a NULL termination.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, this reads much better.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
