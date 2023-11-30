Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LzHmNT7T"
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813851711
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:04 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c210e34088so1190406a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381604; x=1701986404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHxl1acozN9DN8XfsuiOLKeXJM6TT9VtCzHAr1LwSrQ=;
        b=LzHmNT7T9OxxOb1QquTvMGrKV7wO0Sg+X8fJAEm9yzvP8KnKNb3CA4s2nDgc8XBwBL
         wbAnybflvTHmu607/EUPJZjvJsmGVUdEBFA46dSLXI/RJo48n8Y/NsYGqhB2tRXVMeNE
         4xM44BLmBeptCJw0drtptkUFx+WIgaFzGWQ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381604; x=1701986404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHxl1acozN9DN8XfsuiOLKeXJM6TT9VtCzHAr1LwSrQ=;
        b=bcUPcskQMfhKKMigy+LDVzJK+0eFW2EH2jdUTb8DVkiMkDvttslEtboYWeo3qUGusP
         eJkaWXNvZYAtVuO5wTWZ2Cd2qR32AOXUj4g+mXCwfe8Eq3HfrEQocwemsVZT998Tt+A5
         +TeLoCCEYt2lI1o86sOCHCPx+pBmeAF33O1j1Bw7LVXuKkZhJnpVfu0cQ5wIJ7ESCJ8i
         TkgBR/upnGKkrZ72z4KMhFXAQr0o/DRSjtO8jQGe6/hgRDiNdynl6VfXU0poA91hNPH6
         sPPb9F+yQ1AwszbjAe3lvjXFHtfncKISg7PTFxxGk8M3EdsCRBbnFa+sqoDYD60JV1fG
         KgdA==
X-Gm-Message-State: AOJu0YxS8MLP273djAkJYA3BmMynusop/tTZBjKGR4LclsZGTwRDP37v
	PcIMpxg29FgMYczRWE603IFAew==
X-Google-Smtp-Source: AGHT+IFFUtQvkutbCzwEJYcxjo8NsuSrn4mGmVkHUogFLPx4tF/QDvpCKAlGy1xHzlefkRb9ZtgYRA==
X-Received: by 2002:a17:90b:4c4d:b0:285:9a33:258d with SMTP id np13-20020a17090b4c4d00b002859a33258dmr22743450pjb.44.1701381603922;
        Thu, 30 Nov 2023 14:00:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001cfd2c5ae6fsm180457plb.25.2023.11.30.14.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
Date: Thu, 30 Nov 2023 13:59:58 -0800
Message-Id: <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Oct 2023 18:56:50 +0000, Justin Stitt wrote:
> This pattern of strncpy with some pointer arithmetic setting fixed-sized
> intervals with string literal data is a bit weird so let's use
> ethtool_sprintf() as this has more obvious behavior and is less-error
> prone.
> 
> Nicely, we also get to drop a usage of the now deprecated strncpy() [1].
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
      https://git.kernel.org/kees/c/f1c7720549bf

Take care,

-- 
Kees Cook

