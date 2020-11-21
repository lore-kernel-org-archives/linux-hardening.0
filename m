Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD15C63777
	for <linux-hardening@archiver.kernel.org>; Sat, 21 Nov 2020 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2513221FE
	for <linux-hardening@archiver.kernel.org>; Sat, 21 Nov 2020 20:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgKUUAe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 21 Nov 2020 15:00:34 -0500
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:59716 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728402AbgKUUAe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 21 Nov 2020 15:00:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 993CC100E7B42;
        Sat, 21 Nov 2020 20:00:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: band36_01089c827356
X-Filterd-Recvd-Size: 2643
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Nov 2020 20:00:31 +0000 (UTC)
Message-ID: <7456d8ffa0e980e52964c539081228dff4627ae3.camel@perches.com>
Subject: Re: [PATCH 086/141] hwmon: (corsair-cpro) Fix fall-through warnings
 for Clang
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Marius Zachmann <mail@mariuszachmann.de>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Sat, 21 Nov 2020 12:00:30 -0800
In-Reply-To: <20201121185010.GB114144@roeck-us.net>
References: <cover.1605896059.git.gustavoars@kernel.org>
         <be5c59f9bc4bac8c968bbd7443d08eaaf8a28ef8.1605896060.git.gustavoars@kernel.org>
         <20201121185010.GB114144@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 2020-11-21 at 10:50 -0800, Guenter Roeck wrote:
> On Fri, Nov 20, 2020 at 12:36:04PM -0600, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
[]
> > diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
[]
> > @@ -310,6 +310,7 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
> >  		default:
> >  			break;
> >  		}
> > +		break;

The
		default:
			break;

bit above (but not below as it's a switch on an enum) could also be deleted no?

> >  	default:
> >  		break;
> >  	}

---
 drivers/hwmon/corsair-cpro.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index 591929ec217a..580173fca0f6 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -299,17 +299,14 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
 		switch (attr) {
 		case hwmon_pwm_input:
 			return set_pwm(ccp, channel, val);
-		default:
-			break;
 		}
 		break;
 	case hwmon_fan:
 		switch (attr) {
 		case hwmon_fan_target:
 			return set_target(ccp, channel, val);
-		default:
-			break;
 		}
+		break;
 	default:
 		break;
 	}


