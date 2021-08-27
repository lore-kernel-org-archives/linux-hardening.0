Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95649C432BE
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD2B60F39
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 09:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244800AbhH0J1A (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Aug 2021 05:27:00 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:30613 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbhH0J07 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Aug 2021 05:26:59 -0400
Received: from localhost.localdomain ([114.149.34.46])
        by mwinf5d84 with ME
        id mZRz2500A0zjR6y03ZS7Wa; Fri, 27 Aug 2021 11:26:09 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 27 Aug 2021 11:26:09 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/5] stddef: Add flexible array union helper
Date:   Fri, 27 Aug 2021 18:25:32 +0900
Message-Id: <20210827092532.908506-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826050458.1540622-1-keescook@chromium.org>
References: <20210826050458.1540622-1-keescook@chromium.org> <20210826050458.1540622-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> Many places in the kernel want to use a flexible array in a union. This
> is especially common when wanting several different typed trailing
> flexible arrays. Since GCC and Clang don't (on the surface) allow this,
> such structs have traditionally used combinations of zero-element arrays
> instead. This is usually in the form:
> 
> struct thing {
> 	...
> 	struct type1 foo[0];
> 	struct type2 bar[];
> };

At first read, I found the description confusing (and even thought
that there was a copy/paste issue). The subject and the first sentence
is about "flexible arrays in a *union*". Then suddenly, the topic
shifts to *structs*.

After reading at the code, it is clear that this work for both:
  - unions with a flexible array.
  - structures with different typed trailing flexible arrays.

The subject and the description could be updated to clarify that this
macro can be used for both unions and structs.

N.B. this comment only applies to the commit message, the kerneldoc
part is clear.

> This causes problems with size checks against such zero-element arrays
> (for example with -Warray-bounds and -Wzero-length-bounds), so they must
> all be converted to "real" flexible arrays, avoiding warnings like this:
> 
> fs/hpfs/anode.c: In function 'hpfs_add_sector_to_btree':
> fs/hpfs/anode.c:209:27: warning: array subscript 0 is outside the bounds of an interior zero-length array 'struct bplus_internal_node[0]' [-Wzero-length-bounds]
>   209 |    anode->btree.u.internal[0].down = cpu_to_le32(a);
>       |    ~~~~~~~~~~~~~~~~~~~~~~~^~~
> In file included from fs/hpfs/hpfs_fn.h:26,
>                  from fs/hpfs/anode.c:10:
> fs/hpfs/hpfs.h:412:32: note: while referencing 'internal'
>   412 |     struct bplus_internal_node internal[0]; /* (internal) 2-word entries giving
>       |                                ^~~~~~~~
> 
> drivers/net/can/usb/etas_es58x/es58x_fd.c: In function 'es58x_fd_tx_can_msg':
> drivers/net/can/usb/etas_es58x/es58x_fd.c:360:35: warning: array subscript 65535 is outside the bounds of an interior zero-length array 'u8[0]' {aka 'unsigned char[]'} [-Wzero-length-bounds]
>   360 |  tx_can_msg = (typeof(tx_can_msg))&es58x_fd_urb_cmd->raw_msg[msg_len];
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/net/can/usb/etas_es58x/es58x_core.h:22,
>                  from drivers/net/can/usb/etas_es58x/es58x_fd.c:17:
> drivers/net/can/usb/etas_es58x/es58x_fd.h:231:6: note: while referencing 'raw_msg'
>   231 |   u8 raw_msg[0];
>       |      ^~~~~~~
> 
> Introduce DECLARE_FLEX_ARRAY() in support of flexible arrays in unions.

... and structures.

> It is entirely possible to have a flexible array in a union:

It is entirely possible to have one or several flexible arrays in a
structure or a union:

> it just has to
> be in a struct. And since it cannot be alone in a struct, such a struct
> must have at least 1 other named member but that member can be zero sized.
> 
> As with struct_group(), this is needed in UAPI headers as well, so
> implement the core there, with non-UAPI wrapper.
> 
> Additionally update kernel-doc to understand its existence.
> 
> https://github.com/KSPP/linux/issues/137
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/stddef.h      | 13 +++++++++++++
>  include/uapi/linux/stddef.h | 16 ++++++++++++++++
>  scripts/kernel-doc          |  2 ++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index 8b103a53b000..ca507bd5f808 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -84,4 +84,17 @@ enum {
>  #define struct_group_tagged(TAG, NAME, MEMBERS...) \
>  	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
>  
> +/**
> + * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> + *
> + * @TYPE: The type of each flexible array element
> + * @NAME: The name of the flexible array member
> + *
> + * In order to have a flexible array member in a union or alone in a
> + * struct, it needs to be wrapped in an anonymous struct with at least 1
> + * named member, but that member can be empty.
> + */
> +#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
> +	__DECLARE_FLEX_ARRAY(TYPE, NAME)
> +
>  #endif
> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index 610204f7c275..3021ea25a284 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -25,3 +25,19 @@
>  		struct { MEMBERS } ATTRS; \
>  		struct TAG { MEMBERS } ATTRS NAME; \
>  	}
> +
> +/**
> + * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> + *
> + * @TYPE: The type of each flexible array element
> + * @NAME: The name of the flexible array member
> + *
> + * In order to have a flexible array member in a union or alone in a
> + * struct, it needs to be wrapped in an anonymous struct with at least 1
> + * named member, but that member can be empty.
> + */
> +#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> +	struct { \
> +		struct { } __empty_ ## NAME; \
> +		TYPE NAME[]; \
> +	}
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index d9715efbe0b7..65088b512d14 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1263,6 +1263,8 @@ sub dump_struct($$) {
>  	$members =~ s/DECLARE_KFIFO\s*\($args,\s*$args,\s*$args\)/$2 \*$1/gos;
>  	# replace DECLARE_KFIFO_PTR
>  	$members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
> +	# replace DECLARE_FLEX_ARRAY
> +	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
>  	my $declaration = $members;
>  
>  	# Split nested struct/union elements as newer ones
> -- 
> 2.30.2
> 
