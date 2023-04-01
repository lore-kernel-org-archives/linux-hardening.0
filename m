Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BDBC7619A
	for <linux-hardening@archiver.kernel.org>; Sun,  2 Apr 2023 21:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDBVvY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 2 Apr 2023 17:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBVvX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 2 Apr 2023 17:51:23 -0400
X-Greylist: delayed 334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Apr 2023 14:51:21 PDT
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44477299
        for <linux-hardening@vger.kernel.org>; Sun,  2 Apr 2023 14:51:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id B22EC3D0
        for <linux-hardening@vger.kernel.org>; Sun,  2 Apr 2023 23:45:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hera.aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eqQeLLVWKQtL for <linux-hardening@vger.kernel.org>;
        Sun,  2 Apr 2023 23:45:43 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:4a:a400:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 2E693AF
        for <linux-hardening@vger.kernel.org>; Sun,  2 Apr 2023 23:45:43 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1pj5WA-00Apfd-2j
        for linux-hardening@vger.kernel.org;
        Sun, 02 Apr 2023 23:45:42 +0200
Received: from webmel.u-bordeaux.fr [147.210.215.28]
        by begin.youpi.perso.aquilenet.fr with IMAP (fetchmail-6.4.37)
        for <samy@localhost> (single-drop); Sat, 01 Apr 2023 08:25:30 +0200 (CEST)
Received: from v-zimboxp12.srv.u-bordeaux.fr (LHLO
 v-zimboxp12.srv.u-bordeaux.fr) (147.210.219.112) by
 v-zimboxp12.srv.u-bordeaux.fr with LMTP; Sat, 1 Apr 2023 08:25:29 +0200
 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by v-zimboxp12.srv.u-bordeaux.fr (Postfix) with ESMTP id DD69FC0AA0
        for <samuel.thibault@u-bordeaux.fr>; Sat,  1 Apr 2023 08:25:28 +0200 (CEST)
Received: from v-zimboxp12.srv.u-bordeaux.fr ([127.0.0.1])
        by localhost (v-zimboxp12.srv.u-bordeaux.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AFZpRooWBhVM for <samuel.thibault@u-bordeaux.fr>;
        Sat,  1 Apr 2023 08:25:28 +0200 (CEST)
Received: from mta-in02.u-bordeaux.fr (mta-in02.u-bordeaux.fr [147.210.215.18])
        by v-zimboxp12.srv.u-bordeaux.fr (Postfix) with ESMTPS id F2235C2275
        for <samuel.thibault@u-bordeaux.fr>; Sat,  1 Apr 2023 08:25:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mta-in02.u-bordeaux.fr (Postfix) with ESMTP id E0C2CFADA1
        for <samuel.thibault@u-bordeaux.fr>; Sat,  1 Apr 2023 08:25:27 +0200 (CEST)
Received: from mta-in02.u-bordeaux.fr ([127.0.0.1])
        by localhost (mta-in02.u-bordeaux.fr [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OdTOiQXWa6rW for <samuel.thibault@u-bordeaux.fr>;
        Sat,  1 Apr 2023 08:25:27 +0200 (CEST)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by mta-in02.u-bordeaux.fr (Postfix) with ESMTPS id 7C191FADA0
        for <samuel.thibault@u-bordeaux.fr>; Sat,  1 Apr 2023 08:25:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 3083A20156
        for <samuel.thibault@u-bordeaux.fr>; Sat,  1 Apr 2023 08:25:26 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oUvD67gVriIC for <samuel.thibault@u-bordeaux.fr>;
        Sat,  1 Apr 2023 08:25:26 +0200 (CEST)
X-policyd-weight: using cached result; rate: -6.1
Received: from nimbus1.mmprivatehosting.com (nimbus1.mmprivatehosting.com [54.208.90.49])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPS id 1CAB120154
        for <Samuel.Thibault@ens-lyon.org>; Sat,  1 Apr 2023 08:25:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTP id BA80B60034;
        Sat,  1 Apr 2023 06:25:24 +0000 (UTC)
X-Virus-Scanned: amavis at mmprivatehosting.com
Received: from dave.mielke.cc (unknown [174.116.27.113])
        (Authenticated sender: relay@dave.mielke.cc)
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTPA;
        Sat,  1 Apr 2023 06:25:24 +0000 (UTC)
Received: from beta.private.mielke.cc (beta.private.mielke.cc [192.168.0.2])
        by dave.mielke.cc (Postfix) with ESMTPS id 4BA8148E;
        Sat,  1 Apr 2023 02:25:22 -0400 (EDT)
Received: from beta.private.mielke.cc (localhost [127.0.0.1])
        by beta.private.mielke.cc (8.17.1/8.15.2) with ESMTPS id 3316PLDh004836
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 1 Apr 2023 02:25:21 -0400
Received: (from dave@localhost)
        by beta.private.mielke.cc (8.17.1/8.17.1/Submit) id 3316PLs2004835;
        Sat, 1 Apr 2023 02:25:21 -0400
Date:   Sat, 1 Apr 2023 02:25:21 -0400
From:   Dave Mielke <Dave@mielke.cc>
To:     Linux Kernel Mailing List 
        <linux-kernel%40vger.kernel.org@beta.private.mielke.cc>
Cc:     Samuel Thibault <Samuel.Thibault@ens-lyon.org>
Subject: The regrettable demise of the TIOCSTI ioctl.
Message-ID: <ZCfOUSZ87LaBVjq7@beta.private.mielke.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.5 (2021-12-30)
X-Rspamd-Queue-Id: 7C191FADA0
X-Rspamd-Action: no action
X-Rspamd-Server: mta-in02
X-Spamd-Result: default: False [0.01 / 15.00];
        BAYES_HAM(-2.99)[99.97%];
        FORGED_RECIPIENTS(2.00)[m:linux-kernel%40vger.kernel.org@beta.private.mielke.cc,m:Samuel.Thibault@ens-lyon.org,s:samuel.thibault@u-bordeaux.fr];
        MID_RHS_MATCH_TO(1.00)[];
        FORGED_SENDER(0.30)[Dave@mielke.cc,SRS0=8uky=7Y=mielke.cc=dave@bounce.ens-lyon.org];
        R_SPF_ALLOW(-0.20)[+a:sonata.ens-lyon.org];
        MIME_GOOD(-0.10)[text/plain];
        R_DKIM_NA(0.00)[];
        ASN(0.00)[asn:1945, ipnet:140.77.0.0/16, country:EU];
        NEURAL_HAM(-0.00)[-0.761];
        FROM_NEQ_ENVFROM(0.00)[Dave@mielke.cc,SRS0=8uky=7Y=mielke.cc=dave@bounce.ens-lyon.org];
        MIME_TRACE(0.00)[0:+];
        RCPT_COUNT_TWO(0.00)[2];
        MID_RHS_MATCH_FROMTLD(0.00)[];
        RCVD_COUNT_SEVEN(0.00)[9];
        RCVD_VIA_SMTP_AUTH(0.00)[];
        TO_DN_ALL(0.00)[];
        ARC_NA(0.00)[];
        DMARC_NA(0.00)[mielke.cc];
        FROM_HAS_DN(0.00)[];
        RCVD_TLS_LAST(0.00)[]
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

It seems that, starting in the 6.2 kernel (I think), there's a move underway to get rid of the TIOCSTI ioctl. The fact that the kernel configuration information says "provides no meaningful real-world utility any more" shows that the kernel developers seem to be unaware of an important subset of their users who absolutely depend on TIOCSTI.

By removing TIOCSTI, you have broken several users' *ability* to work at all with their current hardware!

The users I'm referring to are those who rely on their ability to work productively with braille devices. They use BRLTTY (see brltty.app). Most braille devices, these days, have braille keyboards. BRLTTY interprets what its users type on those braille keyboards, and uses TIOCSTI to inject those characters. Since I'm unaware of any adequate replacement for TIOCSTI, I'm asking (begging?) that this ioctl please be NOT removed.

Even disablign it isn't good because a blind user who relies on his/her braille keyboard won't be able to fix the problem by logging in and issuing the needed sysctl command (try imagining how you'd do that without your keyboard). We could distribute a brltty.conf sysctl.d file, but that isn't a great idea either given that, in
the end, it'd end up being run on all systems since BRLTTY is generally distributed.

Please understand that it simply isn't true at all that TIOCSTI has no practical use these days. It most certainly does!

Thanks for at least hearing me out.

-- 
I believe the Bible to be the very Word of God: http://Mielke.cc/bible/
Dave Mielke            | 2213 Fox Crescent | WebHome: http://Mielke.cc/
EMail: Dave@Mielke.cc  | Ottawa, Ontario   | Twitter: @Dave_Mielke
Phone: +1 613 726 0014 | Canada  K2A 1H7   |

