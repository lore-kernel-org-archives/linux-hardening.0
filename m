Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9407C433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 18:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8037B613C8
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 18:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhDTSO7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 14:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232879AbhDTSO4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 14:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618942464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVywtcdWzkrND0c18LWsccBuX85KB1TX7A+WSDqF8ww=;
        b=dtBkfNcmBGHJlgb/+53UFJeqGKsPEiNrYFezw23pvZIey+cUQt6sFrE9MRcjJfWhV2Ak/e
        +iUcBE0P1A2usfoQvR6RGZfXAPGl+QR+IwOh4T3mPlZeJOQoMAQQfpVLA3GUVqq5V3zHNy
        xTyhDcUoJxXFWmkIrr+dMVju/N/2+mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-gZ-L1CbPNe6IEJoEIVvKAg-1; Tue, 20 Apr 2021 14:14:17 -0400
X-MC-Unique: gZ-L1CbPNe6IEJoEIVvKAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 989E9802B56;
        Tue, 20 Apr 2021 18:14:15 +0000 (UTC)
Received: from treble (ovpn-115-229.rdu2.redhat.com [10.10.115.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B9C560C5F;
        Tue, 20 Apr 2021 18:14:14 +0000 (UTC)
Date:   Tue, 20 Apr 2021 13:14:12 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 01/15] objtool: Find a destination for jumps beyond the
 section end
Message-ID: <20210420181412.3g5dsyhggxnvif7k@treble>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416203844.3803177-2-samitolvanen@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 01:38:30PM -0700, Sami Tolvanen wrote:
> With -ffunction-sections, Clang can generate a jump beyond the end of
> a section when the section ends in an unreachable instruction.

Why?  Can you show an example?

-- 
Josh

