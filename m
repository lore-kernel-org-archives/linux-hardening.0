Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16DBC433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 18 May 2022 08:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiERIFY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 May 2022 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiERIFX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 May 2022 04:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0924DE7
        for <linux-hardening@vger.kernel.org>; Wed, 18 May 2022 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652861121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=29QeuCJvIYZX5IxA1A2tYSm/a0P9ltwNVD+SSkHIFlk=;
        b=U5miytwtVIppYJxFIKQg3DDmqyhGe2hR1+lY40nL9Wk0Icyuid2RbrjUeQt7pkZn5Y9DMq
        VpaBZAsYxw54xvw9Ips0VP0VPZzKlk9haBjRpUsAEyVsoODb4pcdZ1OZr4uIwjfx1Y4qke
        Zvs8SZUbSDzuerI5cTMHFzxsyS6mGdc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-Y7pGVLVfPF6DqA7BDYgjVQ-1; Wed, 18 May 2022 04:05:16 -0400
X-MC-Unique: Y7pGVLVfPF6DqA7BDYgjVQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A6C11D32371;
        Wed, 18 May 2022 08:05:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92575492C3B;
        Wed, 18 May 2022 08:05:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220517210230.864239-1-keescook@chromium.org>
References: <20220517210230.864239-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netfs: Use container_of() for offset casting
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2692903.1652861114.1@warthog.procyon.org.uk>
Date:   Wed, 18 May 2022 09:05:14 +0100
Message-ID: <2692904.1652861114@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

I wonder if it would be worth making this explicit in the inode wrappers of
the users of netfslib.  In afs, for instance, there is:

	struct afs_vnode {
		struct {
			/* These must be contiguous */
			struct inode	vfs_inode;
			struct netfs_i_context netfs_ctx;
		};
		...
	};

would it be worth making that:

	struct afs_vnode {
		union {
			struct netfs_i_c_pair netfs_inode;
			struct {
				/* These must be contiguous */
				struct inode	vfs_inode;
				struct netfs_i_context netfs_ctx;
			};
		};
		...
	};

I don't want to do the following, say:


	struct afs_vnode {
		struct netfs_i_c_pair ni;
		...
	};

as that would then require a lot of s/->vfs_inode/->ni.vfs_inode/, but maybe
it would be better to include a struct inode in struct netfs_i_context, and
then do:

	struct afs_vnode {
		union {
			struct netfs_i_context netfs_ctx;
			struct inode vfs_inode;
		};
		...
	};

and perhaps rename netfs_i_context to netfs_inode (though that looks a bit
close to nfs_inode).  It's just a shame I can't do:

	struct netfs_inode : inode {
		...
	};

	struct afs_vnode : netfs_inode {
		...
	};

right? ;-)

On the other hand:

	warthog>git grep '[>.]vfs_inode' -- fs/{9p,afs,ceph,cifs,nfs} | wc -l
	181

so maybe a mass change to, say:

	struct netfs_inode {
		struct inode vfs_inode;
		...
	};

	struct afs_vnode {
		struct netfs_inode ni;
		...
	};

wouldn't be so bad.

David

