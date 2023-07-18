Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1194EB64DC
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Jul 2023 20:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGRUXv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Jul 2023 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGRUXu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Jul 2023 16:23:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EE4F9
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jul 2023 13:23:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso5937728276.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jul 2023 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689711828; x=1692303828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaUDO+XAvGDEDxeBgdROw79oqHKS8ZVfSnHPWOLh4Ps=;
        b=sDhQPD6HRuU5a8LfR9o8IZ5FbsbSMdxLx3xiLb3amEp1fzUMS/hoUxUOOYP/YpYGSr
         u3AK/EBrpexE3IEu1DNoSqYfnD5gRdx5fIA8xItGURPEYR9JXu0gSePRPIpsfYUeLhbI
         gGbkdsIRD4oMocDTh1xEAxtZHjFOqLxdgevBunTBwC44ouraGQn+S8eL07qr7ANi6zZf
         cxmBaBl42pWpTVzoTuGqbCJ6x1At/eelI4NXzl4Q/by3Vi+JoGYU9gHfTyTPg7NYF9QE
         BfuHT/ri5lKAhenerLYMyobEAj/Vbc8Hkrat6xDxY0k556UjO0QU7N7TnXKhR89kskBu
         2+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689711828; x=1692303828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaUDO+XAvGDEDxeBgdROw79oqHKS8ZVfSnHPWOLh4Ps=;
        b=Gx8z4wPof1dQ/csx5RIKNWiV0mvdgfQaMVYsOAhPmaHT71RsGk/OZXxM9il+iVOVrK
         SxE6IYX/A5hLmfRpoQpYwEcOL5YrMkgCp6gQKs3RAcBc98rMiINxSHFLSOTtYbcN+Koy
         4hpLkYrTjZoL8LCM8xRDIsjLUVTWoAa8bksGgTq2Gu8k3tFSi2/oGDMXqfIRGOrKuQGA
         uxCy0TAIwK3JMYp/beJMLgCqC8AMG0zQF+MCKlIeygRTagI03dAB2Ma2AUKAWzew6Uns
         u5iQ8yz0a82BkTDJSTzH7121p1+X/tXdyZLs/1TO5H/jB+2WPSjOobpQSEXKYN35t/nB
         hkTg==
X-Gm-Message-State: ABy/qLawmjsiubCRc0xagQuu/b1zAJ0a0w0wZsGJHlAMLLZfcxeH8ad/
        tMVEIMaBPZAFujrKkLKIr+VX7kJLomIqErnB5w==
X-Google-Smtp-Source: APBJJlFinVBlcCNroNPQAxsRWi6jlqX7JL4P4fZ1IpZxMBCLntEGWwQT1Qj2LwDDdPVantfjIQzbLLzphPqfFVFdSw==
X-Received: from yuxiao.svl.corp.google.com ([2620:15c:2a3:200:92bf:e2fa:ba2d:585f])
 (user=yuxiaozhang job=sendgmr) by 2002:a25:bfcd:0:b0:c00:3434:f639 with SMTP
 id q13-20020a25bfcd000000b00c003434f639mr6701ybm.1.1689711828713; Tue, 18 Jul
 2023 13:23:48 -0700 (PDT)
Date:   Tue, 18 Jul 2023 13:23:47 -0700
In-Reply-To: <20230630205358.3601280-1-yuxiaozhang@google.com>
Mime-Version: 1.0
References: <20230630205358.3601280-1-yuxiaozhang@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718202347.3320812-1-yuxiaozhang@google.com>
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc limitation
From:   Yuxiao Zhang <yuxiaozhang@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Friendly ping, any update on this?
