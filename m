Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3379EE
	for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 17:18:03 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA003A3
	for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 10:18:00 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ade5687e97so37673b6e.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695230280; x=1695835080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djhHV7fJ8t7E+0lB6kyqGkm9YZDyiqWfkcZtVTWTflk=;
        b=cABtwnWlXwDGyQYHsIENfXfKZK78hmeDrimH0QmgLBZzYhhg+6GWTZBCSLk5yyzQfV
         pUzXpRCSegu4FZRje1RE710zg8Dwr6wjFEjPX0aemjaxX7i2zWqn7yfWFf2/8xxAMM8c
         h7flpb7jLnsDKGJLVDKQsAwKlhhw86tSUmkxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230280; x=1695835080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djhHV7fJ8t7E+0lB6kyqGkm9YZDyiqWfkcZtVTWTflk=;
        b=PWMIMVXP0s3m3+kqOl5jZdyKy2Cxufzge242rUi1jlz9u3stX+BFJkKXA66tBEjefb
         yh4PaTAax53xeqNxKlyZtoGkgeVQUnOJ33KnClzCPr7IhLcabum1KvjCXNVJonrrWOEs
         gyycFZtETtORK44PStst+kmceQOYplzh464TjHrn4IIOr0jLcbo3aRqOZ/23n9g0+Ly4
         1FlQx/r3SUQ1xGMfersBtxh6pgLWpXg35A0R8+iSI/Z/mYB1JPO2bK7l45/76ZrtWyLL
         5SNcOZGmtG1wsTKYGIl9L9AS738DW3wCK7yTn4muXMcN4L76o0xeNpSWEljxPdi7WGCq
         ZCyw==
X-Gm-Message-State: AOJu0Yx0WZRBoQvdvLqglhx9TUEoMZn8bQdj2lH5tZTGeg28UIXRzQKf
	KKhcX9FUct6n5s2NtPC5AGpv6WbmeGB2me4kaqU=
X-Google-Smtp-Source: AGHT+IEb4oGr9Yfh3zqfuXmltJP9KdaKmsG3ABZU27yO4XJBZpprWJOrx2wid4Sp8sUQQkXCOC9+ZA==
X-Received: by 2002:a05:6808:2219:b0:3a7:53f1:16ac with SMTP id bd25-20020a056808221900b003a753f116acmr3210548oib.20.1695230279526;
        Wed, 20 Sep 2023 10:17:59 -0700 (PDT)
Received: from meerkat.local ([209.226.106.110])
        by smtp.gmail.com with ESMTPSA id dq26-20020a05622a521a00b0040ff6194ef3sm4750816qtb.70.2023.09.20.10.17.59
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:17:59 -0700 (PDT)
Date: Wed, 20 Sep 2023 13:17:50 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-hardening@vger.kernel.org
Subject: Re: This list is being migrated to the new infrastructure
Message-ID: <20230920-zeppelin-heritage-6a15e2@meerkat>
References: <20230920-stoppable-royal-e46a54@meerkat>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920-stoppable-royal-e46a54@meerkat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 12:57:53PM -0400, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> This list is being migrated to the new vger infrastructure. This should be a
> fully transparent process and you don't need to change anything about how you
> participate with the list or how you receive mail.
> 
> There will be a brief 20-minute delay with archives on lore.kernel.org. I will
> follow up once the archive migration has been completed.

This work is now completed. I will monitor the performance to make
sure that the new infrastructure is still successfully coping with the
email traffic.

If you notice any problems, please report them to helpdesk at kernel.org.

-K
