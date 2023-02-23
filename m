Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D4CC64ED6
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Feb 2023 12:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjBWMjF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Feb 2023 07:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjBWMjA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Feb 2023 07:39:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7B0CC00
        for <linux-hardening@vger.kernel.org>; Thu, 23 Feb 2023 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677155876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5faige4boHy1KDnDJFUMGzlyi7Wgdd7JL40G0EvBo0=;
        b=DAd69z/mYzo+WhTe+QrdMa5w37mfk94GO5CzaCRSOEbhF+nhiqNXPbPhC/TArBDxe5+B9+
        liEk1vMkKXZ/PdYUSmxQYw0OoYAvhg33TEnNA7VnKGnwqpzN2PcPOSVg+edfytRdxDJTkD
        bSzjTpjE7EMvgAL9ZDqsoUIkwDr3Q1o=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-WDeSMvYEM_eQVM9eqe2NGw-1; Thu, 23 Feb 2023 07:37:55 -0500
X-MC-Unique: WDeSMvYEM_eQVM9eqe2NGw-1
Received: by mail-io1-f70.google.com with SMTP id s1-20020a6bd301000000b0073e7646594aso6524350iob.8
        for <linux-hardening@vger.kernel.org>; Thu, 23 Feb 2023 04:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5faige4boHy1KDnDJFUMGzlyi7Wgdd7JL40G0EvBo0=;
        b=khuzR7GD+Zc1s9pNhmeBVbRQobPBgo8tg9tfdnzx2FvSoMVO8Y9c+SvEvanrUSa0If
         mqS+mqiqQa8AsX6y8L2MFtOva1j7NfenTyuPQFrBG6HMm4KKD9A1pUktX6XmQOfsOUjY
         qFTpD3NiZ4eyRndaMcsVXZohX038xwGhJ1eqO13RT6Ym4iMR5WcTu/0Om1xVUqMa8ZuK
         rljJL6PJOkiYaKDpTuSHdPnSABbFiYfytAuUqoHK3ITo62JlQSF3VqrnKDgjm9IZqKGw
         kciJb/OLcxLjLrpskMLimSPrG4Uzu200/5jym0i8d4k1oqJh5SbZquJ+D8/Ojos26yYg
         5R2A==
X-Gm-Message-State: AO0yUKUKNRsWUTyFufgNpf4MCz3mc6xg/wQsje+ZJw1KMIRVoP+HtuLR
        Irye2R1Ja24ud3kRhpXXODw3dfHkv0Uh8nq8g2U3f7Pkzn6Id6m7vkwJHlvma4TfVi5f2DOysS6
        /B2VN6Q341zWKuuouQPDsC+Imz2Oo2+kvcA==
X-Received: by 2002:a05:6e02:1445:b0:316:e54a:828f with SMTP id p5-20020a056e02144500b00316e54a828fmr6493865ilo.6.1677155874524;
        Thu, 23 Feb 2023 04:37:54 -0800 (PST)
X-Google-Smtp-Source: AK7set/6AWA4CAuXGZNmzPhHzcrBdzMdBpWOTtYJucrF1Qv97MIIPEiFDxaTnG32VB1VQ2w0xUjrzA==
X-Received: by 2002:a05:6e02:1445:b0:316:e54a:828f with SMTP id p5-20020a056e02144500b00316e54a828fmr6493856ilo.6.1677155874289;
        Thu, 23 Feb 2023 04:37:54 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y22-20020a02bb16000000b0039e89ea68f9sm1759062jan.135.2023.02.23.04.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:37:53 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:37:51 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/6] Add basic Minidump kernel driver support
Message-ID: <Y/deHzijzvuvCJ2M@x1>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 21, 2023 at 04:55:07PM +0530, Mukesh Ojha wrote:
> Minidump is a best effort mechanism to collect useful and predefined data
> for first level of debugging on end user devices running on Qualcomm SoCs.
> It is built on the premise that System on Chip (SoC) or subsystem part of
> SoC crashes, due to a range of hardware and software bugs. Hence, the
> ability to collect accurate data is only a best-effort. The data collected
> could be invalid or corrupted, data collection itself could fail, and so on.
> 
> Qualcomm devices in engineering mode provides a mechanism for generating
> full system ramdumps for post mortem debugging. But in some cases it's
> however not feasible to capture the entire content of RAM. The minidump
> mechanism provides the means for selecting which snippets should be
> included in the ramdump.
> 
> The core of minidump feature is part of Qualcomm's boot firmware code.
> It initializes shared memory (SMEM), which is a part of DDR and
> allocates a small section of SMEM to minidump table i.e also called
> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
> their own table of segments to be included in the minidump and all get
> their reference from G-ToC. Each segment/region has some details like
> name, physical address and it's size etc. and it could be anywhere
> scattered in the DDR.
> 
> Existing upstream Qualcomm remoteproc driver[1] already supports minidump
> feature for remoteproc instances like ADSP, MODEM, ... where predefined
> selective segments of subsystem region can be dumped as part of
> coredump collection which generates smaller size artifacts compared to
> complete coredump of subsystem on crash.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/remoteproc/qcom_common.c#n142
> 
> In addition to managing and querying the APSS minidump description,
> the Linux driver maintains a ELF header in a segment. This segment
> gets updated with section/program header whenever a new entry gets
> registered.

I'd like to test this series plus your series that sets the multiple
download modes. Can you include documentation about how to actually use
this new feature? Also the information that you provided above is really
useful. I think that should also go in the documentation file as well.

I already have a reliable way to make a board go BOOM and go into
ramdump mode.

Brian

