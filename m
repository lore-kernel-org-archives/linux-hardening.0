Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yi1v/4Xg"
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0366F129
	for <linux-hardening@vger.kernel.org>; Fri,  1 Dec 2023 10:20:31 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cdcd790f42so2356334b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 01 Dec 2023 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701454830; x=1702059630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FH0TcrjcnuCcZhjexfAuu7+PxcUWEk5ugjeQLcg8YU=;
        b=Yi1v/4XgjPjmzmxX7Ay50OHL2ufSIr+m2qFwG91eDb22CI/nQjeOaJe23mZI0FvMmR
         nOxZ2BUhBobhumC0YMGvBAcy13YAECeX5iOWfPhKl3S4Je8GOH3tS5yUZ7Xxr1WOP0mp
         wL4pZgma2yqC7I2XBVd2PtEzVhYKySm0Nev08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454830; x=1702059630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FH0TcrjcnuCcZhjexfAuu7+PxcUWEk5ugjeQLcg8YU=;
        b=ZglG9QgNOQgTE5UHrDlcFVdxstuc8gG8RMmU1FCX7Uf7DAQE9dgMd9mpUvLVU4cdVf
         oV/oBrCIG65BRmmkl+x030KT/BrcfQbhY0gKDVrTXdgymFl6L9YDku5qxryGPpieK/8Y
         TfF5CCi3cf2qF3bmMqIs5WeTRlPcBH6u+cj4REHdgmsqb6HWnDwjGnHjtAekh89P7oPR
         ajhCCT46C3xTaY9pyFlMyfpZJv1iisG7hTf3AkykaDgUCcrdM933kgYA6GbFi47WKkak
         Uw+01wRGNrr6H7e9QXJsuy7P066xHuJykxuyKPb5SEobXnVREDrgF64wZCpvTJtukcaU
         RmVw==
X-Gm-Message-State: AOJu0YwNbzJl1Aauq5zbvT4XGTD6x6bzoxZI4h4oG4LaVFl5wtHGvUmu
	r+Xh5P5wno6UKKy8lutwwLyafpwv2k45bzq+GK0=
X-Google-Smtp-Source: AGHT+IHmo+dAmB2azgLcLmANp8ELoQuOdQvcO3kAua9TsyV23+hBWe1Ep5gppWgWzdtq/+AMt8jsyA==
X-Received: by 2002:a05:6a00:2293:b0:6ce:d04:2b46 with SMTP id f19-20020a056a00229300b006ce0d042b46mr1441149pfe.25.1701454830520;
        Fri, 01 Dec 2023 10:20:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k18-20020a6568d2000000b005c1ae0b5440sm3011950pgt.74.2023.12.01.10.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:20:30 -0800 (PST)
Date: Fri, 1 Dec 2023 10:20:29 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ena: replace deprecated strncpy with strscpy
Message-ID: <202312011019.A40455F@keescook>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
 <170138158571.3648714.3841499997574845448.b4-ty@chromium.org>
 <20231130224134.73652d71@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130224134.73652d71@kernel.org>

On Thu, Nov 30, 2023 at 10:41:34PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 13:59:48 -0800 Kees Cook wrote:
> > [1/1] net: ena: replace deprecated strncpy with strscpy
> >       https://git.kernel.org/kees/c/111f5a435d33
> 
> Again, please drop, Arthur requested for the commit message
> to be changed.

Dropped, though I did change the commit message in the pulled commit.

Justin, can you send a v2 with the commit change? Then it can go through
regular netdev machinery?

-- 
Kees Cook
