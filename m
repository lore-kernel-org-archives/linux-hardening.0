Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB83321A3
	for <linux-hardening@vger.kernel.org>; Tue,  9 Dec 2025 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285566; cv=none; b=Fp9iAsTb/+sP0b+TAlPBb201MUVtaV3JkMs9Ry2PqPRi+CXzBvvc2nt2o1SWo0v3msjHlD7iVztuqeopPATp5i/CZQAHGTFFr/dfWVE+D3jrJI7bU231db23k16MIBB613Q7subNA/aECgRdm/jT3Rscj56TJM/fFpENaERPEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285566; c=relaxed/simple;
	bh=5bEfNbrVrbCSOM4MufNJJgr8UqeswnkNURaK3gVvleE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fu+dpXvbZajfCMFSI5l1gRNUGqwyC3LzbCTuXbi93OWk+3qQECzbm9GKVcdyeE/XVR0Qnw+TlEBZrji0xAmcE8Nr23hO/HT0HEN1ksYGBabB6rLtKl0N/3bMayyMZDeaSMYkUNIBSjN+d1SquWGfqg78wEaAZ5AIuZKg2ILIPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a28xa3eg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a28xa3eg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47118259fd8so45786515e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 09 Dec 2025 05:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765285563; x=1765890363; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5XfE5K4iEaC0LFtxMogcKT/LpGujZVN83mgtnotves=;
        b=a28xa3egKrOXRlGRaJ4GHLjpAsUTUBOVleDdVG25w3h7EBUZk4dimziOjkmL/ZyY7E
         sluJ9D6NJhNtiht27JSuqSwYKWDpKvQIzyLEvC99pKkf/J4lJ+IY0GCSZx0JEFIP97gv
         Ig3aMCz6OHrUYHbPDRnofSFOhUCPDEeEXSBU28+GH8MgxYRdrPlXL700fQrocKvm2sjW
         GKQB+BG2qoD13/40qBRTy4aA4uE1C0Wk+u0/8Bcn9eAqtjvlznGOHhbspL80mUgvq4ke
         pSAjKF6IUTPIf3Um7NB7Cv1+tM0J5zeXDc198moj4qX9kd5XMquvi96s05btRj5sbeQZ
         1ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765285563; x=1765890363;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5XfE5K4iEaC0LFtxMogcKT/LpGujZVN83mgtnotves=;
        b=TKzxqbqHywHkbpN0f/xEPh/TQgUbQvXglqWl3jhwDdXvI5c0p/2LYsC+crkuCjy84R
         ti+E6XD40vMOF3QjgL/qhJtYjJmUf2v32vLKi+0GLwIlK1vbhBJa1zlDi0FBktGNh1fS
         C7OmsMnLvOrcMDLHwxH0FGUit1zVH9wwGkiFTsjoJr3FhZzO8Q7OROwRjbeeaD3Uc5uh
         UzKlTLMaclWc2HlnYmNjE9/qAAAZaxKs7kCBGiGd7r2bN6CHnMed8K4izQ1TI3rn1Rnx
         0FyrKcJ6EcopnV/B+jSPgT12fg+ADkV3fF5ubbVk8BcpDZFW6lXcR5tDXC71yQlB7a1S
         lGNA==
X-Gm-Message-State: AOJu0YxEYk0+xjWrFzwiJTh1ufpkC7wcpWL8KR99BctS+BNwx5NUqffJ
	97Wvt4xZgjcjBL+bS4tF5soHIWSGsuNmG6FXE4Rik2ZLsuoxjk7myk9XAoXaphTwN/5GkfxGu95
	WFLJT
X-Gm-Gg: ASbGncugtL262GjUlX5l4oEkFw3Ua14CbQRJUmFPcHH8W82kDn6HBocwFtfApGyhoFJ
	giBf/zoolQFHoGO2p4xHi1d8QZz9txZ8V5XY+9s5Jae+zrgHSYvY4QH1MgYpRRH7LotHi7hla74
	G0/JfBSb6RrEPr/oFQN9Ib2ZL+38qvsRKoM1ykreXw1y0ishJFWw01Q88MRpCbrKVlx+/UX49lt
	8uiCrsP1jRAS4G5srBnMHney7K+o0DlJTsFjdM6YRza1rqXzQ1mF33gMgRYRp/IS7Zs4Nnw8Abf
	W2MCpCsowJKK11Npgjj/D5rjxY0p36el4CCP2FE0S30c/EQ5TLq99lI5S6SHHb2AyrxtMWiPrwj
	ZdVBlkeBewMUqARdmVTpvoX+AugdcdNkNz8IZ2gdNEWcD5IUUNn4npBfNB5phst39ODT8k/j0vD
	j73R/WyjkD98h9rjuH
X-Google-Smtp-Source: AGHT+IHWmUePB12RnPZIMlyymiQnecyOrGf54NEwAysFPvL4/oTjTx6tdoRiHeSlPVbl55vaudVk/w==
X-Received: by 2002:a05:600c:8b52:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-47939df3089mr90298785e9.5.1765285562509;
        Tue, 09 Dec 2025 05:06:02 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d58609esm39608895e9.0.2025.12.09.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 05:06:02 -0800 (PST)
Date: Tue, 9 Dec 2025 16:05:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linux-hardening@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	llvm@lists.linux.dev
Subject: [bug report] clk: visconti: Add support common clock driver and
 reset driver
Message-ID: <aTgetqy8BGerPGTl@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kernel Hardenning developers,

Commit b4cbe606dc36 ("clk: visconti: Add support common clock driver
and reset driver") from Oct 25, 2021 (linux-next), leads to the
question:

drivers/clk/visconti/clkc.c
    187 struct visconti_clk_provider *visconti_init_clk(struct device *dev,
    188                                                 struct regmap *regmap,
    189                                                 unsigned long nr_clks)
    190 {
    191         struct visconti_clk_provider *ctx;
    192         int i;
    193 
    194         ctx = devm_kzalloc(dev, struct_size(ctx, clk_data.hws, nr_clks), GFP_KERNEL);
    195         if (!ctx)
    196                 return ERR_PTR(-ENOMEM);
    197 
    198         for (i = 0; i < nr_clks; ++i)
--> 199                 ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
    200         ctx->clk_data.num = nr_clks;

ctx->clk_data.hws[] is __counted_by() ctx->clk_data.num.  Don't we have to
set the .num before we fill initialize the array?  Or does the checker
code allow us to access the array when the counted by variable is zero?
I seem to remember this used to be a common false positive with the counted
by checking.

    201 
    202         ctx->dev = dev;
    203         ctx->regmap = regmap;
    204 
    205         return ctx;
    206 }

regards,
dan carpenter
