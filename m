Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F20CA77
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBXSd3EK"
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE7CBA
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 23:35:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-323168869daso594020f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 23:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697092521; x=1697697321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQJ/cDndsjVH2agIvBOxH1c6r9a6N1viOd7ZKtxc98s=;
        b=WBXSd3EKP3sUGRyIHh784yWZiUdoeJvSyYSpEYTlvzzHuBDdWC0DZlZyUzP8+fOCDl
         roPdLFAVKhb7c8M7hNZ9SL64twoP+M/BjbNVSWyrhJHualoM1g4Adk5LVb/OJX808zFj
         13/x7C5V48FauTB2TUx1xtoj+FjRQGs8Y9A+WWlnABzMUMaEexyxhuJAJqUUsZFtfgfJ
         S5sMn5XmdcT9h5KGp3NaDeHMYvjLy3es1gqOtrRsMd+Ol1WEhC+GeGZ7rye978aLK+Bn
         Wh2BSg453a2Ce0ImJqGMIsJOdzcKMNZnEnEoyfq+A3a8HKUqwqdVmqFpYywpMycqIZYS
         WQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697092521; x=1697697321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQJ/cDndsjVH2agIvBOxH1c6r9a6N1viOd7ZKtxc98s=;
        b=LWaNIbB8MlbI79EttM6uySiGGHeiqPQEmwhtUggrtzVxT6RGPHt7AqxsZSWLGTwC3Q
         1jEm1xsq2LCAN2MGLwRIt0CKJ8kE8NZufXxYlc/c1wvmhOJUOK3Isgg1vvnoBVGxvh/j
         XPP+M3TaTNJkCrYLdEGkCOUZP52qLwZUA9wQX4GbzMBVdwinI1U9Knvn+phOpESAvsuB
         eAPCdOFMPsxYyFBNe5xhpwm8JRM2nvFaLg9ZuHo+TFbtqLJ77mcA66ZgoIXmeLHvQ6Z1
         4lCi6h1r8z3t5nS5fEJSU/dxnzgC9MBImvcvug4bY4B00rylyt99JimBlOSi2or7Uh89
         qHDw==
X-Gm-Message-State: AOJu0Yz9sLhpCn2KY7k81fjunK7NxUzLLJfLagVatF096cjLk8mHHbU2
	jPPbGO4W7Y/a8fOogUlncQcP/Q==
X-Google-Smtp-Source: AGHT+IGyIk4DWPD2t+N+AVlVanqjBQjctxVfCWWxlM2wMWm7zGXjiSQ9b0DLtWesEsgOMQL+O1Pglg==
X-Received: by 2002:adf:e892:0:b0:31f:a503:c05c with SMTP id d18-20020adfe892000000b0031fa503c05cmr21106870wrm.38.1697092521391;
        Wed, 11 Oct 2023 23:35:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0032d81837433sm4650965wra.30.2023.10.11.23.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:35:21 -0700 (PDT)
Date: Thu, 12 Oct 2023 09:35:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, iommu@lists.linux.dev,
	Joerg Roedel <jroedel@suse.de>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: x86: drop reference to removed config
 AMD_IOMMU_V2
Message-ID: <b9f08b19-80e9-4908-89f1-8712bb3b59e8@kadam.mountain>
References: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
 <7533e359-2024-b69a-2bcf-1906c1a8dbca@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7533e359-2024-b69a-2bcf-1906c1a8dbca@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 10:45:03AM +0530, Vasant Hegde wrote:
> 
> 
> On 10/12/2023 10:20 AM, Lukas Bulwahn wrote:
> > Commit 5a0b11a180a9 ("iommu/amd: Remove iommu_v2 module") removes the
> > config AMD_IOMMU_V2.
> > 
> > Remove the reference to this config in the x86 architecture-specific
> > hardening config fragment as well.
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Joerg, please pick this patch on top of the commit above. Thanks.
> > 
> >  arch/x86/configs/hardening.config | 1 -
> 
> Thanks for the fix Lukas. But I don't see this file in upstream linux tree. Am I
> missing something?
> 

It was added on Aug 24 in linux-next.

regards,
dan carpenter

