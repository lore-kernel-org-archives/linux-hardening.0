Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9A0C7EE2E
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 01:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjFMBEy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 12 Jun 2023 21:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjFMBEx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 12 Jun 2023 21:04:53 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D810E3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Jun 2023 18:04:50 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-19fa4346498so2998551fac.1
        for <linux-hardening@vger.kernel.org>; Mon, 12 Jun 2023 18:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686618290; x=1689210290;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2KQwF+tqN3ar7O8HhmycujLeoInp3ui0gwcQNlvCNwM=;
        b=UPMkiJ0u/r52W3Kl+RYwCsXZJiuT3Mm+08kVKuKrUrkGCKvEq/5lSJwMi3tSatCWX5
         fKZ5SCt7kCgChYFhrjVIJLYlDTWxPiQv1XaGfv/TToLwmRB7FjZR7sz5K7ZNfY9CO0cm
         JuotV47GNcz2c5fAGEv5zOj+PgmFiquq5jF2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686618290; x=1689210290;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KQwF+tqN3ar7O8HhmycujLeoInp3ui0gwcQNlvCNwM=;
        b=QlNGdRQSU+fN/q1BNevJiarQyyaELCp1XYjJcxAcgA7xUPuYvZQHTV1IUiDYSjomfV
         +Vb9iyWZ172Fv9ZpYbIJgOG5NOhOaZld2F9ETzH/IFp6h1+EqHuveuD4QtAGdBVqh8ZR
         fd3KQ3QT0eDyFb4gBdHg+CVRbeeChGeVloESFkx1GcgylhEFo/ZgYzk2NMs6u5eoOtci
         Vq1/y/I2htF/0D0f2UIM0W2iOPSCyVNn/jZr0feeOPBJ6linOjxtlU4dlRp/CjzpiWHs
         qk2Lidpe6SEqHQ7mcae1qQgmkz7f8XTs/dr/YtdEitpdsXoQL+wCTHG6MPL+nreTpPSd
         Ez0A==
X-Gm-Message-State: AC+VfDwsdaiCe93Vfff/TQexw6S8f+DSmhgR+47rkWBWohdHhYRRRPiA
        SF4IeaG7IRz3qa62HtTmRxzO/wYf+nVCI4b5083Kg8LyxFNwLNf1Tj0=
X-Google-Smtp-Source: ACHHUZ6WW8micmaTUxPeuzv4crbx39qJfVCyq0oa28mnsHvqs0eCSd9KdZz6Jyl3DWmK3367T4vJGTsLVQQNnxxgRTw=
X-Received: by 2002:a05:6870:1727:b0:19a:24cf:1597 with SMTP id
 h39-20020a056870172700b0019a24cf1597mr8526640oae.27.1686618289967; Mon, 12
 Jun 2023 18:04:49 -0700 (PDT)
MIME-Version: 1.0
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 12 Jun 2023 18:04:39 -0700
Message-ID: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
Subject: inconsistence in mprotect_fixup mlock_fixup madvise_update_vma
To:     linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

There seems to be inconsistency in different VMA fixup
implementations, for example:
mlock_fixup will skip VMA that is hugettlb, etc, but those checks do
not exist in mprotect_fixup and madvise_update_vma. Wouldn't this be a
problem? the merge/split skipped by mlock_fixup, might get acted on in
the madvice/mprotect case.

mlock_fixup currently check for
if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
vma_is_dax(vma) || vma_is_secretmem(vma))

Should there be a common function to handle VMA merge/split ?

Best
-Jeff
