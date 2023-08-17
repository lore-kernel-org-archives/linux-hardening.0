Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F58DC3DA4E
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 16:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353595AbjHQQVw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353606AbjHQQVb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 12:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470E4273F
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692289242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LKsXf14yPomkD3tSZWQknLH0bmhrzoGBJO+LGRQq7Mg=;
        b=Kz9EzCIQd4zMaqYvD/FC9+ZF4WN6WqQ+PTan4aqJXkhe2PSVDQUkvtEZszvFvQkgB/riEe
        MICmTY6buvgeIAeR43kRzVjfnNDE4XeJ1weoaS+Oe3Hj4GEYsbZmziNLzhM+GFga9sbVAi
        5pS0+sP7Of8O6hh81hZzUDcKOMOuogI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-e5jtcWMRP6mhMfLTjIMZVQ-1; Thu, 17 Aug 2023 12:20:35 -0400
X-MC-Unique: e5jtcWMRP6mhMfLTjIMZVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B851B3C0D86D;
        Thu, 17 Aug 2023 16:18:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id 38C5EC15BAE;
        Thu, 17 Aug 2023 16:18:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 17 Aug 2023 18:17:23 +0200 (CEST)
Date:   Thu, 17 Aug 2023 18:17:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Petr Skocik <pskocik@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mike Christie <michael.christie@oracle.com>,
        Marco Elver <elver@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "haifeng.xu" <haifeng.xu@shopee.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [RFC] signal: Add KUnit tests
Message-ID: <20230817161718.GA4121@redhat.com>
References: <20230814210508.never.871-kees@kernel.org>
 <87bkf68g5m.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkf68g5m.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 08/16, Eric W. Biederman wrote:
>
> Arguably we can skip this as well.  There are only 3 uses of
> do_each_thread (pivot_root, SAK, and ia64 backtrace) and they all should
> be changed to be for_each_process_thread.

Hmm. I thought that do_each_thread() was already killed ...
Let me send the trivial patch.

We also need to kill (or rework) while_each_thread() and next_thread(),
I'll try to do this tomorrow.

Oleg.

