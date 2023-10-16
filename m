Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E6273E2
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqVaub6u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F5106
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697460096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mO4SofqUiQyFUX1ot47zU7IJaXSxrjUqVWuCkw2EMIs=;
	b=fqVaub6u9tMjA06vCmc34XZ5yFsO2TOLpl6Kd9ZgYwAila9vrSnmcjBa6uWgpVQimp4FBo
	741sC2+n+lgAB/8zw/+RjLwZF0CRCJfTNCd9mQxMoTYEQCIw1k0NEzOItJrz2XNLqqRv4B
	kLZ0zu0ROc+lVSEwG6DwwBxmmS5kW5E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-eZEVfMa8PIyZI4LPpv4dqw-1; Mon, 16 Oct 2023 08:41:34 -0400
X-MC-Unique: eZEVfMa8PIyZI4LPpv4dqw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d38d57f49so23484516d6.0
        for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 05:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697460093; x=1698064893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO4SofqUiQyFUX1ot47zU7IJaXSxrjUqVWuCkw2EMIs=;
        b=NDRZWpogzSdPOsTSATvRinrNln+eg5QzEqoCdxGyReeEPNbYDEKHYqsaK7mLBBIUA9
         v0UnWEwMuKIWmeYxSrkP0slfwzY6PPW9b/y5nr6lS0UadThZtZcaJY0HsZYbKY1KHOxC
         0zY8ymGlgg4i3gbqRlsZq9nPGmfB09jcD6QxSb/8rDOg9E2dCHuAcvjFBw7IUfgzbSua
         At/XJ+zg9IQL/FcNgLYIKbIPBjQ9IoHOq4LW3yD9bQyiIUlhEppZtA1Iz3l6XzvpiJLM
         lnwimrgCJOBb7H/vaif+/Romdusn+4ke1FBoRpDUrZL7QC2em0USIWKN2HvC0jBZgJo3
         aIeQ==
X-Gm-Message-State: AOJu0YypXeddwR1cOPzG+dHiawIEDk67SS3jLmtqYPwU/N4PXSR+H3X8
	oucEvH+sWnnBPHy+Mrfxq7JO88HfsktqO6FxI7Vvu2t8Kmh4u3ysmE2khJ/BGO6OJMqUntX3VZb
	X/hyllnJl91uKBzqzyJ0ISX/QCNr5
X-Received: by 2002:a05:6214:262b:b0:66d:63b3:690d with SMTP id gv11-20020a056214262b00b0066d63b3690dmr839216qvb.52.1697460093582;
        Mon, 16 Oct 2023 05:41:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZbF62hLypioq3YKXgp/WQB+xZJQLyIaHwZimjf5t0btZD9gbl26zMY3K8kByPTO5og++YUQ==
X-Received: by 2002:a05:6214:262b:b0:66d:63b3:690d with SMTP id gv11-20020a056214262b00b0066d63b3690dmr839203qvb.52.1697460093330;
        Mon, 16 Oct 2023 05:41:33 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id n9-20020ae9c309000000b0076f0744ff50sm2915824qkg.136.2023.10.16.05.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:41:32 -0700 (PDT)
Date: Mon, 16 Oct 2023 08:41:58 -0400
From: Brian Foster <bfoster@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Refactor bkey_i to use a flexible array
Message-ID: <ZS0vlpSwH1+/+EVM@bfoster>
References: <20231010235609.work.594-kees@kernel.org>
 <ZSkpU0vdrCTfTxuZ@bfoster>
 <202310131637.D0C66BFBA@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202310131637.D0C66BFBA@keescook>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 04:44:21PM -0700, Kees Cook wrote:
> On Fri, Oct 13, 2023 at 07:26:11AM -0400, Brian Foster wrote:
> > On Tue, Oct 10, 2023 at 04:56:12PM -0700, Kees Cook wrote:
> > > The memcpy() in bch2_bkey_append_ptr() is operating on an embedded
> > > fake flexible array. Instead, make it explicit, and convert the memcpy
> > > to target the flexible array instead. Fixes the W=1 warning seen for
> > > -Wstringop-overflow:
> > > 
> > >    In file included from include/linux/string.h:254,
> > >                     from include/linux/bitmap.h:11,
> > >                     from include/linux/cpumask.h:12,
> > >                     from include/linux/smp.h:13,
> > >                     from include/linux/lockdep.h:14,
> > >                     from include/linux/radix-tree.h:14,
> > >                     from include/linux/backing-dev-defs.h:6,
> > >                     from fs/bcachefs/bcachefs.h:182:
> > >    fs/bcachefs/extents.c: In function 'bch2_bkey_append_ptr':
> > >    include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
> > >       57 | #define __underlying_memcpy     __builtin_memcpy
> > >          |                                 ^
> > >    include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
> > >      648 |         __underlying_##op(p, q, __fortify_size);                        \
> > >          |         ^~~~~~~~~~~~~
> > >    include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
> > >      693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
> > >          |                          ^~~~~~~~~~~~~~~~~~~~
> > >    fs/bcachefs/extents.c:235:17: note: in expansion of macro 'memcpy'
> > >      235 |                 memcpy((void *) &k->v + bkey_val_bytes(&k->k),
> > >          |                 ^~~~~~
> > >    fs/bcachefs/bcachefs_format.h:287:33: note: destination object 'v' of size 0
> > >      287 |                 struct bch_val  v;
> > >          |                                 ^
> > > 
> > > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > > Cc: Brian Foster <bfoster@redhat.com>
> > > Cc: linux-bcachefs@vger.kernel.org
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com/
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  fs/bcachefs/bcachefs_format.h | 5 ++++-
> > >  fs/bcachefs/extents.h         | 2 +-
> > >  2 files changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
> > > index f0d130440baa..f5e8cb43697b 100644
> > > --- a/fs/bcachefs/bcachefs_format.h
> > > +++ b/fs/bcachefs/bcachefs_format.h
> > > @@ -300,7 +300,10 @@ struct bkey_i {
> > >  	__u64			_data[0];
> > >  
> > >  	struct bkey	k;
> > > -	struct bch_val	v;
> > > +	union {
> > > +		struct bch_val	v;
> > > +		DECLARE_FLEX_ARRAY(__u8, bytes);
> > > +	};
> > >  };
> > 
> > Hi Kees,
> > 
> > I'm curious if this is something that could be buried in bch_val given
> > it's already kind of a fake structure..? If not, my only nitty comment
> 
> I was thinking it would be best to keep the flexible array has "high" in
> the struct as possible, as in the future more refactoring will be needed
> to avoid having flex arrays overlap with other members in composite
> structures. So instead of pushing into bch_val, I left it at the highest
> level possible, bch_i, as that's the struct being used by the memcpy().
> 
> Eventually proper unions will be needed instead of overlapping bch_i
> with other types, as in:
> 
> struct btree_root {
>         struct btree            *b;
> 
>         /* On disk root - see async splits: */
>         __BKEY_PADDED(key, BKEY_BTREE_PTR_VAL_U64s_MAX);
>         u8                      level;
>         u8                      alive;
>         s8                      error;
> };
> 
> But that's all for the future. Right now I wanted to deal with the more
> pressing matter of a 0-sized array not being zero sized. :)
> 

Ok, but I'm not really following how one approach vs. the other relates
to this particular example of an embedded bkey_i. I'm probably just not
familiar enough with the current issues with 0-sized arrays and the
anticipated path forward. Can you elaborate for somebody who is more
focused on trying to manage the design/complexity of these various key
data structures? For example, what's the practical difference here (for
future work) if the flex array lives in bch_val vs. bkey_i?

Note that I don't necessarily have a strong opinion on this atm, but if
there's a "for future reasons" aspect to this approach I'd like to at
least understand it a little better. ;)

> > is that memcpy(k->bytes[], ...) makes it kind of read like we're copying
> > in opaque key data rather than value data, so perhaps a slightly more
> > descriptive field name would be helpful. But regardless I'd wait until
> > Kent has a chance to comment before changing anything..
> 
> How about "v_bytes" instead of "bytes"? Or if it really is preferred,
> I can move the flex array into bch_val -- it just seems like the wrong
> layer...
> 

Yeah.. v_bytes, value_bytes, etc. etc. Anything that avoids misleading
code when using the field is good with me. Thanks.

Brian

> -Kees
> 
> > 
> > Brian
> > 
> > >  
> > >  #define KEY(_inode, _offset, _size)					\
> > > diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
> > > index 7ee8d031bb6c..6248e17bbac5 100644
> > > --- a/fs/bcachefs/extents.h
> > > +++ b/fs/bcachefs/extents.h
> > > @@ -642,7 +642,7 @@ static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr
> > >  
> > >  		ptr.type = 1 << BCH_EXTENT_ENTRY_ptr;
> > >  
> > > -		memcpy((void *) &k->v + bkey_val_bytes(&k->k),
> > > +		memcpy(&k->bytes[bkey_val_bytes(&k->k)],
> > >  		       &ptr,
> > >  		       sizeof(ptr));
> > >  		k->k.u64s++;
> > > -- 
> > > 2.34.1
> > > 
> > 
> 
> -- 
> Kees Cook
> 

