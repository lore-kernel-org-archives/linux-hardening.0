Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TQ9pbjhK"
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA3B1704
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 13:59:54 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5bd5809f63aso1153126a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381594; x=1701986394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c42AEDWMN7hJC14TW3ZzrgHN/RRiE6AQecjZVC97Rac=;
        b=TQ9pbjhKrU5rFQvy+B1+FAg+X9JVsucoA3CuPnU/XHjtqk31ej/8NAiYDrGhpJ6X9E
         7/94nJmCozCed82FI4dkFZXQE5cXSut5U47nXLX91GT3FZ08XXIZuLpUBNYRheSTIO7W
         oiu4PPQPMAQgWPMA3ypSZNo1yq1gvGIegDfLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381594; x=1701986394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c42AEDWMN7hJC14TW3ZzrgHN/RRiE6AQecjZVC97Rac=;
        b=BiOTTXLji7lsBWTjvzMl2a8LQeZAcjGrL4vC1qIYGx1tSJE1FQXA24xULv9u1Rjzno
         zPA1CYCw6XXmdeuP1AVLOvpOYWx5xKGOSQk8LDDCq/zMsz5sa6czB2Ca+MetLSj2lU6x
         mzAd+GHaqQaCzS9f4udYq9J8hb+Z+E4wDn1MdYdoElLYp2iKR7QriD92Q4YGHoVg2DfM
         HZoS8m7bBLcu90PdN+IqB5fuVDui0B3PII3PTwDC/jGurty4qAtjg5fhbEHygnSoeweu
         Y148dQc2uyh5BT1viROllqxU83X33ROy5isvtxPaI0kY4H4NngGN47496nvKDuD+aEq1
         NzEw==
X-Gm-Message-State: AOJu0Yx0J2j6eQyG+HE5LBgApYMpGfMAOy5HdhfGnsoP/nxWVm5O/fjy
	44tZIk+8lR0q9DP+9LERI4oJJw==
X-Google-Smtp-Source: AGHT+IFop+NWNhZlt3dMNp594BdhHVQM6A0+JlzJPIGXbIDsGz+ug3GkLRQiPue5S2QQlbddVCJDDQ==
X-Received: by 2002:a05:6a20:3d0d:b0:18c:52d:8f79 with SMTP id y13-20020a056a203d0d00b0018c052d8f79mr24539635pzi.62.1701381594434;
        Thu, 30 Nov 2023 13:59:54 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001cf658f20ecsm1891636plg.96.2023.11.30.13.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:59:53 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ena: replace deprecated strncpy with strscpy
Date: Thu, 30 Nov 2023 13:59:48 -0800
Message-Id: <170138158571.3648714.3841499997574845448.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Oct 2023 00:56:08 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not necessary as host_info is initialized to
> `ena_dev->host_attr.host_info` which is ultimately zero-initialized via
> alloc_etherdev_mq().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] net: ena: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/111f5a435d33

Take care,

-- 
Kees Cook

