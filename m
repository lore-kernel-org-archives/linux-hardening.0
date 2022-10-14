Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E50C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 14 Oct 2022 20:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJNUAL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJNUAK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 14 Oct 2022 16:00:10 -0400
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Oct 2022 13:00:07 PDT
Received: from mail.postadigitale.org (mail.postadigitale.org [IPv6:2a01:4f8:200:34ed::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5AD474D6
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 13:00:06 -0700 (PDT)
Received: from hostpad (p5490ffec.dip0.t-ipconnect.de [84.144.255.236])
        by mail.postadigitale.org (Postfix) with ESMTPSA id 21C761B888
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 21:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postadigitale.de;
        s=20180517; t=1665777073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=HFaeA+wUVWjM4Ud+YuLqAJrZPhM2ET6pBiH1t8QPuH4=;
        b=DxR28wAeLyOXzhu3sWW+7AuZNhaxJ2PDrQ4DZ5QNO1dAWVSbK6URo23kAk/EdYWdO7OD/r
        CMxDow89QGEp+1eg0XYhjVXEa0dYUpb/qi/+0IIG7HCBJqB5UqcwjmgDObBcpL2afm30OV
        4ArtOf+Mi18jEbcbzK0RjdxjaouwEbM=
Date:   Fri, 14 Oct 2022 19:51:11 +0000
From:   Simon Brand <simon.brand@postadigitale.de>
To:     linux-hardening@vger.kernel.org
Subject: Reconsider possibility to disable icotl TIOCSTI
Message-ID: <Y0m9l52AKmw6Yxi1@hostpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Good day,

please reconsider to add a possibility to disable icotl TIOCSTI.
In the past there have been attempts to restrict the TIOCSTI ioctl. [0, 1]
None of them are present in the current kernel.
Since those tries there have been some security issues (sandbox
escapes in flatpak (CVE-2019-10063) [2] and snap (CVE 2019-7303) [3],
runuser [4], su [5]).

I ask to merge the patches from linux-hardening [6, 7] so users can
opt out of this behavior. These patches provide the
`SECURITY_TIOCSTI_RESTRICT` Kconfig (default no) and a
`tiocsti_restrict` sysctl.

Escapes can be reproduced easiliy (on archlinux) via a python script:
```
import fcntl
import termios
with open("/dev/tty", "w") as fd:
    for c in "id\n":
        fcntl.ioctl(fd, termios.TIOCSTI, c)
```
Now run as root:
# su user
$ python3 /path/to/script.py ; exit
uid=0(root) ...

I asked it before on kernelnewbies mailing list. [8]

Best and thank you,
Simon

[0] https://lkml.kernel.org/lkml/CAG48ez1NBnrsPnHN6D9nbOJP6+Q6zEV9vfx9q7ME4Eti-vRmhQ@mail.gmail.com/T/
[1] https://lkml.kernel.org/lkml/20170420174100.GA16822@mail.hallyn.com/T/
[2] https://github.com/flatpak/flatpak/issues/2782
[3] https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SnapIoctlTIOCSTI
[4] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=815922
[5] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=628843
[6] https://github.com/anthraxx/linux-hardened/commit/d0e49deb1a39dc64e7c7db3340579
[7] https://github.com/anthraxx/linux-hardened/commit/ea8f20602a993c90125bf08da3989
[8] https://www.spinics.net/lists/newbies/msg64019.html
