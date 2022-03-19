Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233B3C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 19 Mar 2022 12:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiCSMMC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 19 Mar 2022 08:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbiCSMMB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 19 Mar 2022 08:12:01 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574F113D2C
        for <linux-hardening@vger.kernel.org>; Sat, 19 Mar 2022 05:10:40 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id h126so20281248ybc.1
        for <linux-hardening@vger.kernel.org>; Sat, 19 Mar 2022 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sdeJyx83K3lPLVc496VLDfBIQyJhPzjAW0FyOcnIdls=;
        b=N9ZACpk3BgTaoUzESeEFnqFMhRO478KDS/LJaMvyJ7ynaNF4va6qVzO8R5NeDZHEno
         zYPyx/+nrYGhtpqz7ZHygtRWW5rMJ2x+PTSmy16VZnV+kguWT+MfDejPIuDrs0DvHiOj
         D1RxvkdLkdi58dSDLOAD5kwN3Q25oQJWbF6LGxaMhA8fs+j64zphGQyKOCCeKMsNVf4o
         AZbmUkwOzSNbLJbiqQ7VrIEndeCYEEsa+mtBWOMCHNUrqv20mvbbVrxO009ncQs2jGQc
         TnsJEO0DIrdVi8ogZwm2mI7LYI9dbq8YUdiAGd6CFqgOFBA1LHnKai0y0/2ocigaaDIC
         fmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sdeJyx83K3lPLVc496VLDfBIQyJhPzjAW0FyOcnIdls=;
        b=gd875Qx4ge1c35Xoc59mATKwBso5guJqORiVRnyBqk3TsysvLjQbH8zjFem6DX1P8/
         DSuMMgm8nmsgn4GxmdMNrf3TyePmdWdsAbNHWr7NHlbPKNvVydWpweYiLiQP1SQI07yG
         sHE/UiqRFJBGMdiuGB8tc7w4E3jtkP49S2B5+Z2jooRbMKqE/enn+Q4oDLaeiCLatHWd
         0JZrEbMA40lfepNv3gNKqrJWnyoy30H6w6e8pkGAQpexMoqI92h7O7gRGFsDuoHDbHvp
         iK4B203WZHQskqTbEi4lrg99Eo6H+z8GFmtdxIW+s10McBRGauJvXWXWebDtK4qyADoD
         6qUQ==
X-Gm-Message-State: AOAM531f56YgLL2A+IDVan0wTqY++MPTWpJ2MoCUlq+vnJ7mwkGrd5Ou
        79or27F+Rj/o6bazz9/MFGg0C3XyXsWAkpXSCvZDRYh8+ZyotA==
X-Google-Smtp-Source: ABdhPJwMyiTwArSzPLl7HQdHAZ2OzlCKiB5a5Qj8dLen9Ky1FAzQ6SQsFVMsDVhpQ28q5aQL3xdp6Bp1dc8ywDUXfvg=
X-Received: by 2002:a25:f904:0:b0:628:a84d:a105 with SMTP id
 q4-20020a25f904000000b00628a84da105mr13704142ybe.53.1647691839547; Sat, 19
 Mar 2022 05:10:39 -0700 (PDT)
MIME-Version: 1.0
From:   Derrick McKee <derrick.mckee@gmail.com>
Date:   Sat, 19 Mar 2022 08:10:34 -0400
Message-ID: <CAJoBWHxmsWThoQXNXRfDwmT2z=iEtwPQMU1iVtTZdNmqaCCaeQ@mail.gmail.com>
Subject: CVE Proofs of Concept
To:     kernel-hardening@lists.openwall.com
Cc:     linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

I am a Ph.D. student at Purdue University researching kernel
compartmentalization.  I am currently conducting evaluation for a
follow-up paper to one published at NDSS 22 titled 'Preventing Kernel
Hacks with HAKC' (see [1]).  We are interested in empirically
evaluating our compartmentalization policies by determining if targets
of exploits (which we refer to as exploit sinks) are placed in a
different compartment from code that accesses the target (which we
refer to as exploit sources).

To that end, we are looking for a set of kernel exploit proofs of
concept that we can execute and examine.  I realize such a set could
be sensitive, and I will follow all safety procedures in the handling
and execution of any PoC.  In lieu of a set of PoCs, are there any
statistics of kernel structures that are targeted by attackers?  I
would imagine, for example, that struct cred would be heavily
targeted, but how often and what other kernel structures are targeted
would be invaluable.  Thank you for any insight you might have.

[1] https://www.ndss-symposium.org/ndss2022/accepted-papers/


-- 
Derrick McKee
Phone: (703) 957-9362
Email: derrick.mckee@gmail.com
