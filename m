Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6067FC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Oct 2021 02:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37701613A9
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Oct 2021 02:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhJVCza (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 22:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232556AbhJVCz3 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 22:55:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5D266135E;
        Fri, 22 Oct 2021 02:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634871193;
        bh=ZOyHbxAA1KVGEYcWxP49OLWHjX0kWfehynxD5OBUUVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MYl6fk548La85NrwC/69S4sKIJvdsbVdNXs9wgOfrX7zVeEh/JVjMuVJBaPLdbpOv
         yHO9iNYMoEIeXZ4Knv8ctrzbhv+1IHA7gfgUii2lsO4Z1rDVMBq+9Vt7vQ5kaYqlcd
         ZuG4B+l/nqSUKKafT4TqvA0ZbCZUdliClZeG8epA=
Date:   Thu, 21 Oct 2021 19:53:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Jordy Zomer <jordy@jordyzomer.github.io>, linux-mm@kvack.org,
        Dmitry Vyukov <dvyukov@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/secretmem: Avoid letting secretmem_users drop to
 zero
Message-Id: <20211021195311.6058b90f573641542605dae4@linux-foundation.org>
In-Reply-To: <20211021154046.880251-1-keescook@chromium.org>
References: <20211021154046.880251-1-keescook@chromium.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 21 Oct 2021 08:40:46 -0700 Kees Cook <keescook@chromium.org> wrote:

> Quoting Dmitry: "refcount_inc() needs to be done before fd_install().
> After fd_install() finishes, the fd can be used by userspace and we can
> have secret data in memory before the refcount_inc().
> 
> A straightforward mis-use where a user will predict the returned fd
> in another thread before the syscall returns and will use it to store
> secret data is somewhat dubious because such a user just shoots themself
> in the foot.
> 
> But a more interesting mis-use would be to close the predicted fd and
> decrement the refcount before the corresponding refcount_inc, this way
> one can briefly drop the refcount to zero while there are other users
> of secretmem."
> 
> Move fd_install() after refcount_inc().

I added cc:stable.  Or doesn't the benefit/risk ratio justify that?
