Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FADCEB64D8
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 10:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjFVKrh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Jun 2023 06:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFVKrf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Jun 2023 06:47:35 -0400
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 03:47:32 PDT
Received: from forward204c.mail.yandex.net (forward204c.mail.yandex.net [178.154.239.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D6D19B4
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 03:47:32 -0700 (PDT)
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by forward204c.mail.yandex.net (Yandex) with ESMTP id F0F8F6140E
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 13:42:21 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:5e29:0:640:6b8b:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id E04A960139;
        Thu, 22 Jun 2023 13:42:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GgDRYL4DSSw0-TgVHY75N;
        Thu, 22 Jun 2023 13:42:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687430536;
        bh=MTlX4FfSsa+SjbT7mwpow96OuuSAsltYniOgOWr3iZs=;
        h=Subject:From:Cc:To:Date:Message-ID;
        b=Tzo1LMAh4mCGYnrrRRxEH22WsP7UIWZck3qO8RstScOaGQGG6biDAvAHFj9JyIEQc
         C3E2aLFgzC6FYtvsgyHeDFTLwwubJTHCovU4YG3Dr4oPMhtLCWInAj7HgOHkLgbb3U
         rU0tm9BzKjCg8WAoCCf5eo7tPr3s3AoEAS4+ocDI=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <1f3f722c-657d-21ec-d6e2-7f79ce5462e3@yandex.ru>
Date:   Thu, 22 Jun 2023 13:42:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: On clang vs. gcc fortify warnings
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Recently I've observed a (not so?) subtle difference using CONFIG_FORTIFY_SOURCE=y
with clang vs. gcc. The problem may be illustrated by the following tiny module:

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/fortify-string.h>

static const char example[][32] = {
	"abcd",
	"xyzt",
	"1234",
	"5678"
};

static int __init test_init(void) {
	char data0[128], data1[128];

	/* No warnings with both gcc 13.1.1 and clang 16.0.5 */
         memcpy(data0, example, sizeof(example));

	/* No warning with gcc 13.1.1 but warning with clang 16.0.5:

	   ./include/linux/fortify-string.h:529:4: warning: call to
	   '__read_overflow2_field' declared with 'warning' attribute:
	   detected read beyond size of field (2nd parameter); maybe
	   use struct_group()? [-Wattribute-warning]
                         __read_overflow2_field(q_size_field, size);
	*/
	
	memcpy(data1, *example, sizeof(example));
         return 0;
}

static void __exit test_exit(void) {
}

module_init(test_init);
module_exit(test_exit);

MODULE_LICENSE("GPL");

I suppose that clang wins here because 'memcpy(data1, *example, sizeof(example))'
may be interpreted as an attempt to copy 128 bytes from 32-byte source buffer.
So the question is why gcc don't diagnose this as well.

Thanks,
Dmitry
