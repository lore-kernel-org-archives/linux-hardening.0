Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428D5C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 18 May 2022 15:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbiERPVN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 May 2022 11:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiERPVM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 May 2022 11:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 726FB2655B
        for <linux-hardening@vger.kernel.org>; Wed, 18 May 2022 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652887270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ehACCvrw7UhqaYWryKtTRqeTT9ThoHFc3Uj/+RsDps=;
        b=f+RPEPX0g05Xp8zSBrg97nnARam73C4RLenmlMILPGhvsA9DVAAjM9pIORf0OTExZBt1Gk
        QnCcWG5rPwXSq0KuyaX6iee4ysJaK8DaBswlrN46y+RgsnavutJ6s0CvFxAXExxvVdbPwX
        GqUwHlMHnFpZ5sw4s93MrDm0ulUjgvg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-ThK-0Q9EP52LdzYlHYzTEA-1; Wed, 18 May 2022 11:21:07 -0400
X-MC-Unique: ThK-0Q9EP52LdzYlHYzTEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE9853C11731;
        Wed, 18 May 2022 15:21:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 237EAC28101;
        Wed, 18 May 2022 15:21:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <aa9e13f50be440a192b6acbce422db96@AcuMS.aculab.com>
References: <aa9e13f50be440a192b6acbce422db96@AcuMS.aculab.com> <20220517210230.864239-1-keescook@chromium.org> <2692904.1652861114@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Kees Cook <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] netfs: Use container_of() for offset casting
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2953402.1652887264.1@warthog.procyon.org.uk>
Date:   Wed, 18 May 2022 16:21:04 +0100
Message-ID: <2953403.1652887264@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> Can't you just name the structure so it is:
> 
> 	struct afs_vnode {
>  		struct netfs_i_c_pair {
>  			/* These must be contiguous */
>  			struct inode	vfs_inode;
>  			struct netfs_i_context netfs_ctx;
>  		};
>  		...
>  	};

No.  C won't let you do that (the same thing has to be done in 9p, ceph as
well, and at some point hopefully cifs and nfs too).

David

