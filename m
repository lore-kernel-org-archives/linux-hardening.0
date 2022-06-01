Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A415DCCA473
	for <linux-hardening@archiver.kernel.org>; Wed,  1 Jun 2022 15:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiFAPug (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346113AbiFAPug (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 1 Jun 2022 11:50:36 -0400
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 08:50:33 PDT
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA1CBA5021
        for <linux-hardening@vger.kernel.org>; Wed,  1 Jun 2022 08:50:32 -0700 (PDT)
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
        by smtpfb1-g21.free.fr (Postfix) with ESMTP id 43B13DF9FB9
        for <linux-hardening@vger.kernel.org>; Wed,  1 Jun 2022 17:41:57 +0200 (CEST)
Received: from [IPV6:2a01:e35:39f2:1220:9f4d:1e36:2cff:ddf9] (unknown [IPv6:2a01:e35:39f2:1220:9f4d:1e36:2cff:ddf9])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id 90CD919F58D;
        Wed,  1 Jun 2022 17:41:47 +0200 (CEST)
Message-ID: <fd5cf4a3-ba98-5c98-f823-e83f58a1d40c@opteya.com>
Date:   Wed, 1 Jun 2022 17:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Possibility of merge of disable icotl TIOCSTI patch
Content-Language: fr-FR
To:     Simon Brand <simon.brand@postadigitale.de>,
        kernelnewbies@kernelnewbies.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <Yoy9IqTvch7lBwdT@hostpad>
From:   Yann Droneaud <ydroneaud@opteya.com>
Organization: OPTEYA
In-Reply-To: <Yoy9IqTvch7lBwdT@hostpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

Le 24/05/2022 à 13:10, Simon Brand a écrit :
> Hi,
>
> in the past there have been attempts to restrict the TIOCSTI ioctl. [0, 1]
> None of them are present in the current kernel.
> Since those tries there have been some security issues (sandbox
> escapes in flatpak (CVE-2019-10063) [2] and snap (CVE 2019-7303) [3],
> runuser [4], su [5]).
>
> I would provide a patch which leaves the current behavior as default,
> but TIOCSTI can be disabled via Kconfig or cmdline switch.
> Is there any chance this will get merged in 2022, since past
> attempts failed?
>
> Escapes can be reproduced easiliy (on archlinux) via a python script:
> ```
> import fcntl
> import termios
> with open("/dev/tty", "w") as fd:
>      for c in "id\n":
>          fcntl.ioctl(fd, termios.TIOCSTI, c)
> ```
> Now run as root:
> # su user
> $ python3 /path/to/script.py ; exit
> uid=0(root) ...
>
> Best,
> Simon
>
>
> [0] https://lkml.kernel.org/lkml/CAG48ez1NBnrsPnHN6D9nbOJP6+Q6zEV9vfx9q7ME4Eti-vRmhQ@mail.gmail.com/T/
> [1] https://lkml.kernel.org/lkml/20170420174100.GA16822@mail.hallyn.com/T/
> [2] https://github.com/flatpak/flatpak/issues/2782
> [3] https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SnapIoctlTIOCSTI
> [4] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=815922
> [5] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=628843
>

This is probably some topic for (kernel|linux)-hardening@ mailing lists.


Regards.

-- 

Yann Droneaud

OPTEYA


