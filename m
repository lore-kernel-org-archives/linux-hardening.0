Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0753BEB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 18:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjF1SsY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 14:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjF1SsY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 14:48:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D1B1FF7
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 11:48:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb2202e0108so48044276.1
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687978102; x=1690570102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnnDEXrg/gkS/C7srVAqIZGcztE6wO7dbfqWYSxKCy4=;
        b=6PAR7Npi8ERaYChyaM+1wl8PfqDVMWaRkcCtpbbS/XEKjfr05+Ro0K9USuAb+eufOr
         h/ro1Q/tP9CLLoTUmmxV82f/liy3cZ8icxTWd8VGrVlLveNRXYIAU5OJUYVxyLnr0gUW
         Y7Z4iD2RQxrpBUuHeLTIjq81we4+waGdJq22oRpgLgIFNaF/9M6mDK4Ina4I4pW5Hlbs
         WzGX7hJ0qxX4xionOv44NTJgbFmWU1NLe9t2hnUr+yVLrdnIc0/P5Fvctariw9dj2Y1V
         iQdGh8OWi02JgJkSM0Brhi5vSoesDVRTmcjISQf8bxjhPgYvpJqyhUGW6F+e6l3CMznh
         1TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687978102; x=1690570102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnnDEXrg/gkS/C7srVAqIZGcztE6wO7dbfqWYSxKCy4=;
        b=W/Xnqg4rD3jKKelkDDfbQ9NAM6ky+m2h8yIMZG5SOI49qGXRBEoo+YnmUjDIw6r1iy
         iQ+3hYEY7bSZABwyKbWs+RLl80f7agEy3ZPm5PC+p5hbX3avr2Y/JlxIEj2sZECMR1VY
         sRIiQFwgRx9j6qexObPhdUijcdQAERRToNf84m6HTRBwIpt3AMrT5+E5p7Sru7oL9gwa
         sBaMMQ4aEV0AeMMguzbZZoRW7CTZPGoB8f8tjLv0MTPzjrLtm4dFap9zJOXeXcyCgPBD
         pgBD+aMUz944mJPu20BEEYA2iDzCyGbz1KFG8h5xK93n4bVBjj0TyUrePifftMwsKVKW
         25Ug==
X-Gm-Message-State: ABy/qLYV1Ey/MqNZTRtmEjRTYQ4L7b4AUMlxFZvKZyNqF/GI8GLq0pq6
        7B4WgqIPFtLcUTynuJWS485wDosh9GFse0DHIA==
X-Google-Smtp-Source: APBJJlFwj3ft8PJXuauN4m6BQgeng7EycnUWJJ8yZOOIAcurN18/szcbl9SlfQzQQsFl+u7T/7Men90wScQkVVCVkQ==
X-Received: from yuxiao.svl.corp.google.com ([2620:15c:2a3:200:ee8e:ae51:26:66dc])
 (user=yuxiaozhang job=sendgmr) by 2002:a25:781:0:b0:c39:d6f6:481f with SMTP
 id 123-20020a250781000000b00c39d6f6481fmr7552ybh.10.1687978101888; Wed, 28
 Jun 2023 11:48:21 -0700 (PDT)
Date:   Wed, 28 Jun 2023 11:48:20 -0700
In-Reply-To: <b2d66d9f-15a6-415c-2485-44649027a1d5@igalia.com>
Mime-Version: 1.0
References: <b2d66d9f-15a6-415c-2485-44649027a1d5@igalia.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628184820.1375994-1-yuxiaozhang@google.com>
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc limitation
From:   Yuxiao Zhang <yuxiaozhang@google.com>
To:     Kees Cook <keescook@chromium.org>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Thanks for the review Kees.

>And yes, Greg's questions are all good -- fixing syntax and adding size
details in the commit log would be appreciated.

Sure, will send another patch to address this.

Hi Guilherme, thanks for testing this patch.

>But when I tried to increase the record size in ramoops, I got this error: https://termbin.com/b12e

What record type are you testing? I should have mention that this patch is only for pmsg use case on ramoops (I mentioned it in the original thread but need to start a new one due to format issue).

>Also - Kees certainly knows that way better, but - are we 100% sure that
the region for pstore can be non-contiguous? For some reason, I always
thought this was a requirement

Right, that is why this patch only touches the pstore ram path, I am not sure how things will go if it is block device backed.

Thanks,
-Yuxiao Zhang
