Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7819B
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 02:57:17 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D376180
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 19:57:15 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1dcfb2a3282so707298fac.2
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 19:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695524234; x=1696129034; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NPXBmCzK3FG70guuha+2I+A6yn1HdDxLwlr5P+cFkHs=;
        b=O63eZjVFAjb/vmW9m3BmvPdxALTCh7hQu/tYUx5AitrO91BWsWLPDk4CL76jtUPDLW
         dXEDJkXkJm1O8Yc0UUK2ED/GA8T0qDTAwlazEeaBuj0xUA3g88RT4Y39aGKaaOOTvcqV
         qRp8TvB3HGyHc2lJd4MWOo2sRryLIWtn0kF/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695524234; x=1696129034;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPXBmCzK3FG70guuha+2I+A6yn1HdDxLwlr5P+cFkHs=;
        b=gk07nOnT2JJtT8MkQgiFnbGRavl4RFJXd+FMaMuCgGFc2Kx/OlpmE6E6ZCqPC8FZb4
         F0YvpmLI+Rw1YRi+UdXhb/uPkkB/Up8OJc92+Ji6LguzDQF7Xaeh33Ld6u2rax4283PM
         rquUL4JL46KpR8jKtf2ktHlIOAWzoicuOVYfn9oGTMhacj4HfV75G+fwnqWsmFSpMO2H
         R6PvjA29jHrpG6MfFk55n/qhk7w3rn9f4dlM1ZsRFP5lV3IsdKW0rS8TV1UivDWhoBM7
         TD9HiabRtev42zfWG2IKyaGRzWRIdyZZn+Xhl5/a4X4CJCfTpHzXfdw5vhkIBiCNzErT
         eqFA==
X-Gm-Message-State: AOJu0Ywgyxc9fphwsdXxrkX6A/1y77EULfPL9wfXJa9Htgd2jzL8eQpa
	lBmnytXZ5YdipOY4tjsVWbYeIg==
X-Google-Smtp-Source: AGHT+IFK1V+i4tYBOwcJa9hlcUbQL0WgYEFL3YN7gDnaCzlxB+A01+MYEGZT9yHCPBAf6SjDQGiVSQ==
X-Received: by 2002:a05:6870:6486:b0:1c0:c42f:6db2 with SMTP id cz6-20020a056870648600b001c0c42f6db2mr4979469oab.37.1695524233832;
        Sat, 23 Sep 2023 19:57:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m29-20020a638c1d000000b005787395e301sm3964077pgd.44.2023.09.23.19.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:57:12 -0700 (PDT)
Date: Sat, 23 Sep 2023 19:57:12 -0700
From: Kees Cook <keescook@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] udmabuf: Fix a potential (and unlikely) access to
 unallocated memory
Message-ID: <202309231954.1EAD0FA5A7@keescook>
References: <3e37f05c7593f1016f0a46de188b3357cbbd0c0b.1695060389.git.christophe.jaillet@wanadoo.fr>
 <7043f179-b670-db3c-3ab0-a1f3e991add9@embeddedor.com>
 <a49f800e-e56f-433a-81d2-6edd68a0a015@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a49f800e-e56f-433a-81d2-6edd68a0a015@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 09:22:44PM +0200, Christophe JAILLET wrote:
> Le 18/09/2023 à 05:10, Gustavo A. R. Silva a écrit :
> > 
> > 
> > On 9/18/23 12:46, Christophe JAILLET wrote:
> > > If 'list_limit' is set to a very high value, 'lsize' computation could
> > > overflow if 'head.count' is big enough.
> > > 
> > > In such a case, udmabuf_create() will access to memory beyond 'list'.
> > > 
> > > Use size_mul() to saturate the value, and have memdup_user() fail.
> > > 
> > > Fixes: fbb0de795078 ("Add udmabuf misc device")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > >   drivers/dma-buf/udmabuf.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > > index c40645999648..fb4c4b5b3332 100644
> > > --- a/drivers/dma-buf/udmabuf.c
> > > +++ b/drivers/dma-buf/udmabuf.c
> > > @@ -314,13 +314,13 @@ static long udmabuf_ioctl_create_list(struct
> > > file *filp, unsigned long arg)
> > >       struct udmabuf_create_list head;
> > >       struct udmabuf_create_item *list;
> > >       int ret = -EINVAL;
> > > -    u32 lsize;
> > > +    size_t lsize;
> > >       if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
> > >           return -EFAULT;
> > >       if (head.count > list_limit)
> > >           return -EINVAL;
> > > -    lsize = sizeof(struct udmabuf_create_item) * head.count;
> > > +    lsize = size_mul(sizeof(struct udmabuf_create_item), head.count);
> > >       list = memdup_user((void __user *)(arg + sizeof(head)), lsize);
> > >       if (IS_ERR(list))
> > >           return PTR_ERR(list);
> > 
> > How about this, and we get rid of `lsize`:
> 
> Keeping or removing lsize is mostly a matter of taste, I think.

I'm on the fence, but kind of lean towards keeping lsize, but I think
it's fine either way.

> Using sizeof(*list) is better.

That I agree with, yes.

> Let see if there are some other comments, and I'll send a v2.

I note that this looks like a use-case for the very recently proposed
memdup_array_user():
https://lore.kernel.org/all/ACD75DAA-AF42-486C-B44B-9272EF302E3D@kernel.org/

(i.e. a built-in size_mul)

-Kees

-- 
Kees Cook
