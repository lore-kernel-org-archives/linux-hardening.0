Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD5C7EE23
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Feb 2023 19:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjBXTHD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBXTHC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Feb 2023 14:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6D867E38
        for <linux-hardening@vger.kernel.org>; Fri, 24 Feb 2023 11:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677265574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TO32MmHRC5X6hVdeytKpEjQuFgiB4c62vSXkbsV3be0=;
        b=WXBTdavGtQCQbNkP7kadATukugCPdMjKuH4+2uBRb6NkQtiFHO1FxURwdvLR1nIkiWPzpi
        /eovh7talXctrILE90YYA7lOwiJILwopNCHgCuBLnYyjLFvZJZuMEKHxmovwEXdNYPAjxR
        JRfIKRMfpJ4oGi9CP1gGC8tdalIaFW8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-345-z_OpTj0FN2mw8Vp0W2sTxw-1; Fri, 24 Feb 2023 14:06:11 -0500
X-MC-Unique: z_OpTj0FN2mw8Vp0W2sTxw-1
Received: by mail-io1-f72.google.com with SMTP id 9-20020a5ea509000000b0074ca36737d2so3300175iog.7
        for <linux-hardening@vger.kernel.org>; Fri, 24 Feb 2023 11:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO32MmHRC5X6hVdeytKpEjQuFgiB4c62vSXkbsV3be0=;
        b=IdoOv+zzbIZ0MvBCw3K5DMVnai5zs5LNkRkv7GMtrn0mWXEIFFEYEe0nKXSQcImkDH
         Cu8zOZ6mqG17muFOQhzIE21a4fD5sKIW2VPNlPyS6i5nIg+fKLZxAoRxOyY7iVMPDivP
         sZk5WQXbVW7pipLBGgjJcQniNF0mBVxUJO3ssxbwLZ0Z1/87ymab8+LuPQ5LOFnyxdBb
         CKxsqQGqFxAstTzSp2sa/VzXegkfzyPHImKcgENJFRt6M/l3fMgmr49hiZ6pesT8LLBZ
         rzF49FFMXBYCakNd/3iOELo3E+i1Y3rVMLul+BV4Pxwi7BBsc4TQfgVGBqOqyC9YYBFa
         oVqA==
X-Gm-Message-State: AO0yUKVG0cOab7eIHmSMf5yBZsf3uMOj779EvFutYCVQuy364yS/VUZu
        suHfnhoud9V/0h/e+4t/rkE2y2UCLJC2zc5A4rfO16zYCjYY4lbqCW4B32CLq/aIa7WCD9dOMD9
        8dxpKSPxMoQLNEYyH740K/78HEIsS
X-Received: by 2002:a05:6602:200f:b0:74c:bc54:def6 with SMTP id y15-20020a056602200f00b0074cbc54def6mr790439iod.16.1677265571053;
        Fri, 24 Feb 2023 11:06:11 -0800 (PST)
X-Google-Smtp-Source: AK7set9/Pv5CyL/4mD4A9Y4Q/LVOJsbK7o9jmpBuvUza9YaJUBhEetobrRKdqPedvvHaEaB9J1UmPg==
X-Received: by 2002:a05:6602:200f:b0:74c:bc54:def6 with SMTP id y15-20020a056602200f00b0074cbc54def6mr790426iod.16.1677265570885;
        Fri, 24 Feb 2023 11:06:10 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id l5-20020a6b7b05000000b0073f8a470bacsm24221iop.16.2023.02.24.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 11:06:09 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:06:07 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/6] Add basic Minidump kernel driver support
Message-ID: <Y/kKn9tnvSQ2Pacn@x1>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
 <Y/deHzijzvuvCJ2M@x1>
 <47542dbb-8cf3-6eae-a38e-910d38bd960b@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <47542dbb-8cf3-6eae-a38e-910d38bd960b@quicinc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Mukesh,

On Fri, Feb 24, 2023 at 04:10:42PM +0530, Mukesh Ojha wrote:
> On 2/23/2023 6:07 PM, Brian Masney wrote:
> > I'd like to test this series plus your series that sets the multiple
> > download modes.
> 
> Sure, you are welcome, but for that you need a device running with Qualcomm
> SoC and if it has a upstream support.

I will be testing this series on a sa8540p (QDrive3 Automotive
Development Board), which has the sc8280xp SoC with good upstream
support. This is also the same board that I have a reliable way to
make the board crash due to a known firmware bug.

> Also, testing of this patch needs some minimal out of tree patches and
> i can help you with that.

Yup, that's fine. Hopefully we can also work to get those dependencies
merged upstream as well.

Brian

