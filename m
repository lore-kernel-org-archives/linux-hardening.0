Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343B15AC2
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I09895eL"
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88636A9
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 14:39:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9bca1d96cso2609645ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697060341; x=1697665141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQYo9++dcgxg2nv6IP2UpMdMgwP0vkzDdfVUM+eI3FY=;
        b=I09895eLrI5XblTDto+MsftearTwecZ1+uKPTERgGj4Z6oY7xkmJZDleh9w+DZunJ9
         YRZ0ejocqqe7cwz5L7fDnrZgCVh1e1YtIZyXyH4R7t+w9OD5Wlp4iURUOxvPV25ZfgU0
         IL6CX53TbjqWpEqtTFu5TbvqAQmLkYihhtaz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060341; x=1697665141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQYo9++dcgxg2nv6IP2UpMdMgwP0vkzDdfVUM+eI3FY=;
        b=bngOJLA0NL46Fkk56U0QIf45nDdHNIQnmvJZFEV3oRqJT/ooJHni2qBdQmkQdAKx60
         iG8QZYSVKFPSHKsaXCj8C5ZR6TymkhzUX2BVmzLXwXKbbUuFAThF00I38BOG4ym6j40I
         8LR0tx5OQps340LMAGLF4/hEIblD/QGh8f/p1qEFuHghLxJHrOme/MUiQpB7dPuAmHqp
         PgMJ7Vr5aGIIt7Z1A0+1J9yVZ9x2vGdtPm33Wt+u/zQrxsc/bXJ0CRY9w7tS0Sv9wqza
         O1J9R7vic9oGk7T7dLN+4JVU1LlC8KXlc4ZnHrqNtmERvjOg38i9Au+Bh9QLn7i9vLgk
         BHkQ==
X-Gm-Message-State: AOJu0YzEg8m6PNqZQEXiKb+7Cbr87nLOmu1qi93JmdUGZoAAOtsScp8p
	h9NcUDU9Ah8mdUJB9A9fGkcdhQ==
X-Google-Smtp-Source: AGHT+IF8K3Psvkfh1b6MDcUT6LfA9+V/N9SI10hvEG8lDfYQ/D8Ss8oCO45dIi8LZzUECZ4tb7vggA==
X-Received: by 2002:a17:903:120f:b0:1bb:994c:bc43 with SMTP id l15-20020a170903120f00b001bb994cbc43mr22837597plh.18.1697060340983;
        Wed, 11 Oct 2023 14:39:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001c55db80b14sm305424plg.221.2023.10.11.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:39:00 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:38:59 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] clk: socfpga: Fix undefined behavior bug in
 struct stratix10_clock_data
Message-ID: <202310111438.2D0168C@keescook>
References: <cover.1697059539.git.gustavoars@kernel.org>
 <5dd8483177dc8cd91d021170b6717f2e570bab03.1697059539.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd8483177dc8cd91d021170b6717f2e570bab03.1697059539.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 03:34:03PM -0600, Gustavo A. R. Silva wrote:
> `struct clk_hw_onecell_data` is a flexible structure, which means that
> it contains flexible-array member at the bottom, in this case array
> `hws`:
> 
> include/linux/clk-provider.h:
> 1380 struct clk_hw_onecell_data {
> 1381         unsigned int num;
> 1382         struct clk_hw *hws[] __counted_by(num);
> 1383 };
> 
> This could potentially lead to an overwrite of the objects following
> `clk_data` in `struct stratix10_clock_data`, in this case
> `void __iomem *base;` at run-time:
> 
> drivers/clk/socfpga/stratix10-clk.h:
>   9 struct stratix10_clock_data {
>  10         struct clk_hw_onecell_data      clk_data;
>  11         void __iomem            *base;
>  12 };
> 
> There are currently three different places where memory is allocated for
> `struct stratix10_clock_data`, including the flex-array `hws` in
> `struct clk_hw_onecell_data`:
> 
> drivers/clk/socfpga/clk-agilex.c:
> 469         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
> 470                                 num_clks), GFP_KERNEL);
> 
> drivers/clk/socfpga/clk-agilex.c:
> 509         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
> 510                                 num_clks), GFP_KERNEL);
> 
> drivers/clk/socfpga/clk-s10.c:
> 400         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
> 401                                                  num_clks), GFP_KERNEL);
> 
> I'll use just one of them to describe the issue. See below.
> 
> Notice that a total of 440 bytes are allocated for flexible-array member
> `hws` at line 469:
> 
> include/dt-bindings/clock/agilex-clock.h:
>  70 #define AGILEX_NUM_CLKS	55
> 
> drivers/clk/socfpga/clk-agilex.c:
> 459         struct stratix10_clock_data *clk_data;
> 460         void __iomem *base;
> ...
> 466
> 467         num_clks = AGILEX_NUM_CLKS;
> 468
> 469         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
> 470                                 num_clks), GFP_KERNEL);
> 
> `struct_size(clk_data, clk_data.hws, num_clks)`	above translates to
> sizeof(struct stratix10_clock_data) + sizeof(struct clk_hw *) * 55 ==
> 16 + 8 * 55 == 16 + 440
> 		    ^^^
> 		     |
> 	allocated bytes for flex-array `hws`
> 
> 474         for (i = 0; i < num_clks; i++)
> 475                 clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
> 476
> 477         clk_data->base = base;
> 
> and then some data is written into both `hws` and `base` objects.
> 
> Fix this by placing the declaration of object `clk_data` at the end of
> `struct stratix10_clock_data`. Also, add a comment to make it clear
> that this object must always be last in the structure.
> 
> Fixes: ba7e258425ac ("clk: socfpga: Convert to s10/agilex/n5x to use clk_hw")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Nice find!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
