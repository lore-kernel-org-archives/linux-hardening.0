Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DA0C54EBE
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 07:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbjAMHJm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 02:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbjAMHJT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 02:09:19 -0500
X-Greylist: delayed 975 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 22:57:19 PST
Received: from 4.mo575.mail-out.ovh.net (4.mo575.mail-out.ovh.net [46.105.59.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001F67D1C7
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 22:57:19 -0800 (PST)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.16.164])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 5314D22F8A
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 06:41:03 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-xdp7s (unknown [10.108.1.53])
        by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0CA6C1FF12;
        Fri, 13 Jan 2023 06:41:03 +0000 (UTC)
Received: from RCM-web7.webmail.mail.ovh.net ([151.80.29.19])
        by ghost-submission-6684bf9d7b-xdp7s with ESMTPSA
        id 4OIWAf/8wGPowRkAd8AKww
        (envelope-from <rafal@milecki.pl>); Fri, 13 Jan 2023 06:41:02 +0000
MIME-Version: 1.0
Date:   Fri, 13 Jan 2023 07:41:02 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nvmem: u-boot-env: replace zero-length array with
 flexible-array member
In-Reply-To: <Y7zB+s2AC6O+CRR+@work>
References: <Y7zB+s2AC6O+CRR+@work>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <494915c85c52e66aa83fce49556ccf3e@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18230289816807779163
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrleejgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpefgueelueetteefueehhffhgfetvdegjeefleffuedvhfeuffdvheegueevuefhleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdduleegrddukeejrdejgedrvdeffedpudehuddrkedtrddvledrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhhrghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2023-01-10 02:40, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> array declaration in struct u_boot_env_image_broadcom with flex-array
> member.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].

I also handled this issue in my
[PATCH V2 4/6] nvmem: u-boot-env: convert to layout driver
https://lore.kernel.org/linux-arm-kernel/20230111073102.8147-4-zajec5@gmail.com/
