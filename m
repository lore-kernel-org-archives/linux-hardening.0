Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69A5C54EBE
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Jan 2023 14:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjAPOzN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 Jan 2023 09:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjAPOyR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 Jan 2023 09:54:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2B22A35
        for <linux-hardening@vger.kernel.org>; Mon, 16 Jan 2023 06:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673880105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NOdvTIf1x9tQkJ1orPjPgaQ6ppXgSvc8Pon55J0dM/o=;
        b=Fd9m6sDPSlRM7HM2LZ0AMAspmexTaTngIHRBR3bUpWGpgpdM4AP6aCLgcRdk4DSlMpH90W
        HkqIIiqeTsMpppoWsaMhf9JrefdBKYb9GORuRLqAGP1Z6PMl4+KOQ/tMreBUpO1k5FtHu9
        i5sJ3Ra6a9KgH65vy25CU2MMBBtl42o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-EuWS6VfxMmy9PUMhWE79bQ-1; Mon, 16 Jan 2023 09:41:42 -0500
X-MC-Unique: EuWS6VfxMmy9PUMhWE79bQ-1
Received: by mail-lj1-f197.google.com with SMTP id a25-20020a05651c211900b0028b7a49f813so1228569ljq.19
        for <linux-hardening@vger.kernel.org>; Mon, 16 Jan 2023 06:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOdvTIf1x9tQkJ1orPjPgaQ6ppXgSvc8Pon55J0dM/o=;
        b=5wqipFzs4QR0sftROoh0WL9BYZhlHNkIBWnK4b+5F/8FreGvBQjJssBK0RlCIfZqaj
         GeRC+ZjWXrfuwGoD10d7rYgNJEW51IDwcBowoHmbKLgk46z5xyEoTd5vZMCMq8FQHf0q
         SV87CSVeqVOwb4tCm4ps0gQECyPeEumuWTqtlDj2/4ZCxEGRZQMRhpN6/97Io4oXN/IW
         ZfK2T3MWK1bL1+I3j34DkTHG0h4d+WR7R6sI7gy5u0wpqSQzecIbLLdt1MRCPb5mj8n7
         pQzYdb9QFXlm81qv8s4CPbyGo8HTDOxfESCYdnJzWX9ARI9WgcvO0xAswobNOBVwZGMd
         iDsQ==
X-Gm-Message-State: AFqh2kp4at4zuq6CVicuSUSplnw5iLtsFWCBR3CnNIbOQZnx210RILvR
        i/JXWgC1ib1lU5d33iRm1MNjgX1gnE14yz1SKOVvknh5tCK6CHnebDoUDr4ry9MDG2/OBMUFV+o
        7o/0IyAcJePDaZZR6gogJqRQVFCajYomnJr+V8sBaZ8W6
X-Received: by 2002:a2e:a278:0:b0:276:4462:2d20 with SMTP id k24-20020a2ea278000000b0027644622d20mr2377ljm.19.1673880100988;
        Mon, 16 Jan 2023 06:41:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt9sY30K02/f5zO7kr1kC+X6IUBM2xn7/y8ozy2/Ri3RfIQeuDJUUrDrh1bQKXOq8bdG47xKQOTvByre+UJEzQ=
X-Received: by 2002:a2e:a278:0:b0:276:4462:2d20 with SMTP id
 k24-20020a2ea278000000b0027644622d20mr2374ljm.19.1673880100820; Mon, 16 Jan
 2023 06:41:40 -0800 (PST)
MIME-Version: 1.0
References: <Y7zB0q2pr7lEpHGs@work> <202301121449.EE489AA@keescook>
In-Reply-To: <202301121449.EE489AA@keescook>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 16 Jan 2023 15:41:29 +0100
Message-ID: <CACO55ttCY1KbqWqzGS1adrJno6kUs7b5_QY7X1AE6qYUqztWNQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/nouveau/nvkm: Replace zero-length array with
 flexible-array member
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

will push in a moment

On Thu, Jan 12, 2023 at 11:49 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jan 09, 2023 at 07:39:30PM -0600, Gustavo A. R. Silva wrote:
> > Zero-length arrays are deprecated[1] and we are moving towards
> > adopting C99 flexible-array members instead. So, replace zero-length
> > array declaration in struct nvfw_hs_load_header_v2 with flex-array
> > member.
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [2].
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> > Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> > Link: https://github.com/KSPP/linux/issues/78
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
>

