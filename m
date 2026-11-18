Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005839;
	b=I0Sxu3ZiRf3B/xv+tmyHFsvxU38oYVE+j8EZofwoVXe3GulKAsU6r7jl/AC6gJn//FZM
	 4dL4984friK5b6D7FnmymBlj0IUABuoxYmNbu9KJ8sS3aUq10nGbugutt13LWn3k2NZa2
	 zaIVTfL5SIijGy6r+mMC17DkP0zQ8ymCdbELDj+L77LqoU3kGlOC4NRqjo0TIqiTQagPO
	 WE0+niOZw9pTXCzSbfM/VEs6uQtbNax+MpmAnngfdro37pSQE0yUyWnh/4YSfvny/VIIv
	 RkVziSOCaEoeq7Pke4HeArSAugd+oBCJuqN4/iHnLnF8v+moEZufC7GMrAO1lBhnwQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005839;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gC10VzDGHK2VJeM7ibqIPA7PShFYGqEoG8ozb5T2OzQ=;
	b=ltU2zU6NdvV4P0dnUTvzAR3X0vmzUod15/nfPAeAJTPtnnPxc8MASQP7+kIkKUGFjY/P
	 5Pw1PRo7L9X3sHcukUssZKuHuqVjJrR2GuB80mu4r6VdPguTUwIlzLG4PBtohq0ANpeRP
	 6O6TfWG4gcNiF0Wh6BAWSaBQl7f3PP88q++4xbEDFiNGMII9fwpR1FXgVALWfhUdh23U8
	 d1CBLPzIzObluspLCf6T/J9tLSDHOVi3drWWTykobiMaW1q7Zx8ybbAzjZkM41QuVVSxh
	 KrXBB5X68uWwMBSd5MWRWlTvyndM57o3fGGFGz+lfg+BB5rf8mBADuVvFNGqc1HYJwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlIvnwJp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DA606A31C;
	Wed, 18 Nov 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlIvnwJp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16151F000C4;
	Wed, 18 Nov 2026 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005839;
	bh=gC10VzDGHK2VJeM7ibqIPA7PShFYGqEoG8ozb5T2OzQ=;
	h=From:Subject:Date:To:Cc;
	b=IlIvnwJpDpE4FK3fg6xoebsUkS65WZPuXByUSQyBQsv+w6cSZg8BngQQWxcrZDaYO
	 fihU9irzHzJbiOjtoQn37XfyIRaTUly5P5OIV4vPC8WGc1jkxnsjHRVe5TaTBwhDWL
	 9dvp4YbtBXjOqt78vdoSuNirK7l0PfA69ltAFnbCyAgrLBXC5FnzX9nsb/epBgCm4d
	 cUhlH8Gei4DGKOH1l4QMSrMiMcDtMuveBvf/UvWsXRpnmDDbyJjGvxvu7QSzAixT3n
	 Y1EnbSBUebqWV179Trn0mdXiwRVCqxFrdd8OwtHDmkw4klkfCQhmZ7Ybd9MXhR+6US
	 aoqnnIOhqBGQQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH RFC v2 00/16] media: Fault-Tolerant V4L2
Date: Wed, 18 Nov 2026 13:43:44 +0100
Message-Id: <20261118-v4l2-sensor-detect-v2-0-1bb1a445b556@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQrCMBBEf6Xs2UiyqdV4EgQ/wKv00KZrG1oS2
 ZSglP67sWePb4Z5s0AkdhThXCzAlFx0wWfAXQF2aHxPwnWZASVW0qAWqZxQRPIxsOhoJjsLjY1
 s0ejKWgV5+GJ6uvcmfcD9doU6h4OLc+DPdpTUVv2cSkr1z5mUkKIpD8boltSxPV1GYk/TPnAP9
 bquX+Qxp3y6AAAA
X-Change-ID: 20260923-v4l2-sensor-detect-32a0b2936cc1
To: Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Andy Walls <awalls@md.metrocast.net>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nicolas Dufresne <nicolas.dufres@collabora.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Michael Riesch <michael.riesch@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Maxime Ripard <mripard@kernel.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7840;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=o8f6emCddhrPySCyohc2k1Y5UF+Ua+DfDaTjoTlw94E=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2K4VjVvTIGXxafDia8ubS3HMyneSQ4P8DZZ
 N96aKwnLKKJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2digAKCRAZDR20Zk4Z
 NWlYCACDVzOuTtecfiFack+u6/zqMad6nvdeJyZjz903xsXfin5cT9Q2vLT4kzDW80Iz6RBvsaz
 5yU3ZtJ6P5BWGnR7+RvIAcuJMyw9ZU+oA+J5DY9c5ZNZ8eXnN7tjQ0yrg5AP4P/InQa687MPTmx
 cZNob2tNTvmA7ANlDR5ipbktHG8TUtJIRUcQl2Ta1wZQBdWN2KFGHpqhCgr6WVHbotxPs5rykU6
 IG0z+C3+g5ylXiUsx/YghlgnRxSj8GRYPOvDwqREC+8MdBMX0rdl60TVEKHZd4rjZJ7HIHl/lKr
 WMtDCuE8vvbY3FKLmaktwtmuBaJWJ+R/w6v/EVdn5Amg1zwo
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

On media-centric camera pipelines, every entity is known at boot time
and described statically (for example via device-tree).

The V4L2 framework assumes that every entity of the camera
pipeline is always present. This is a reasonable assumption for
integrated cameras in laptops or phones. However, in automotive systems,
cameras (e.g. rear-view or surround-view) can be damaged or disconnected.
When the framework assumes all sensors are present, a single missing
camera can prevent the entire pipeline from operating.

This is a known problem and has been discussed at various conferences:
* https://www.linuxtv.org/downloads/presentations/media_summit_2026/Michael%20-%20The%20Butterfly%20Effect.pdf
* https://www.linuxtv.org/news.php?entry=2022-11-14-0.hverkuil
* https://lore.kernel.org/linux-media/20261021224119.GA383235@killaraus.ideasonboard.com/T/#u

For example, in the following pipeline:
"""
  imx219  9-0010 -> ds90ub953 7-0044 -> ds90ub960 pad0 -+
                                                        |-- pad4 -> cdns_csi2rx -> ticsi2rx
  imx219 10-0010 -> ds90ub953 7-0045 -> ds90ub960 pad1 -+
"""

If imx219 9-0010 fails to probe, media-ctl -p will show:
"""
                    ds90ub953 7-0044 -> ds90ub960 pad0 -+
                                                        |-- pad4 -> cdns_csi2rx -> ticsi2rx
  imx219 10-0010 -> ds90ub953 7-0045 -> ds90ub960 pad1 -+
"""

Now, if ds90ub953 7-0044 fails to probe(), media-ctl -p will only show the
following topology:
"""
                                                                    cdns_csi2rx -> ticsi2rx
"""

To solve this, we chose to go for a simple solution inspired by
DRM connectors.

We created an ioctl for media entitities to report their current
connection status.
This allows applications to discover an entity state when discovering
the graph (using media-ctl -p, for example)
The entity status is then cached. When applications start streaming,
the status is polled on a regular basis and reported as a media event
every time it changes.
This mandates that the driver can probe even when the device is
not connected.

This has the benefits of being fairly simple to implement, understand
and support in drivers.

This new behaviour is opt-in. It is enabled via a module parameter
for the Media Controler: mc.fault_tolerant.

Patch 1-9 Add event support at media device level
Patch 10-14 Add entity status and ioctls to interact with it
Patch 15-16 implement this pattern switch for the imx219 driver.

With this, we can hot-plug the sensor and get notified via the media
device of the status:

[root@fedora]# ./media-event-monitor
Subscribed to ENTITY_REGISTRATION and ENTITY_STATUS_CHANGE on /dev/media0
Waiting for events (Ctrl-C to quit)...
event: type=2 (ENTITY_STATUS_CHANGE) id=0 seq=0 ts=403045107120 pending=0
  entity_id=40 status=DISCONNECTED
event: type=2 (ENTITY_STATUS_CHANGE) id=0 seq=1 ts=415292362587 pending=0
  entity_id=40 status=CONNECTED

The code for this demo is available at:
https://gitlab.com/-/snippets/6077614

The media device event code is mostly Sakari's work which can be found at:
https://git.linuxtv.org/sailus/media_tree.git/log/?h=partial-reg

Current known limitations:
* Only leaf entities (typically sensor nodes) are covered. We should
  also address entities that are in the middle of the media graph

This has been tested on a SK-AM69 board on top of the following series:
* https://lore.kernel.org/all/20260824121451.3348583-1-sakari.ailus@linux.intel.com/
* https://lore.kernel.org/all/20261104-j721e-csi2rx-crash-sd-enable-streams-v1-1-b77ee38c8dcf@kernel.org/

Thanks,
Mattijs

---
Changes in v2:
- Notifications are now done at media device level (Laurent, Nicolas)
- Connection status is tracked at entity level (Laurent)
- imx219: Fail the probe if CHIP_ID does not match (Dave)
- Dropped patch 'media: imx219: Move LP-11 state switch to power_on()'
  as we did not get any feedback from cadence on this
- Replaced VIDIOC_SUBDEV_G_CONNECTION_STATUS with a media controller
  ioctl instead: MEDIA_IOC_G_ENTITY_STATUS
- Do status polling in generic framework (Dave)
- Increase polling interval to 10s (Dave)
- Polling/Fault tolerance is only enabled when mc.faul_tolerance=1
  module param is set (Dave, Hans V, Sakari)
- Reworked .detect() polling to be only done when streaming is on. This
  should address the privacy led blinking concerns (Dave, Hans D)
- Link to v1: https://lore.kernel.org/r/20261001-v4l2-sensor-detect-v1-0-a45993be17b8@kernel.org

---
Laurent Pinchart (1):
      media: mc: Add per-file-handle data support

Mattijs Korpershoek (7):
      media: media.h: Add entity connection status
      media: mc: Add .detect() to media_entity_operations
      media: mc: Add MEDIA_IOC_G_ENTITY_STATUS ioctl
      media: mc: Add MEDIA_EVENT_ENTITY_STATUS_CHANGE event
      media: mc: Add detect polling helpers for drivers
      media: imx219: Allow driver probe with missing sensor
      media: imx219: Implement .detect() sensor operation

Sakari Ailus (8):
      media: mc: Add struct media_device_fh pointer to media device IOCTL op
      v4l: event: Separate event related information from struct v4l2_fh
      v4l: event: Rework data structures for separating events and V4L2
      v4l: event: Split the event framework into generic and V4L2 bits
      media: mc: Maintain a list of open file handles in a media device
      media: mc: Add MEDIA_IOC_DQEVENT
      media: mc: Add MEDIA_EVENT_ENTITY_REGISTRATION
      Documentation: media: Add Media controller event documentation

 .../userspace-api/media/mediactl/media-funcs.rst   |   3 +
 .../media/mediactl/media-ioc-dqevent.rst           | 130 +++++++++
 .../media/mediactl/media-ioc-g-entity-status.rst   |  92 ++++++
 .../media/mediactl/media-ioc-subscribe-event.rst   | 112 +++++++
 drivers/media/Kconfig                              |   3 +
 drivers/media/i2c/imx219.c                         | 117 +++++---
 drivers/media/mc/Kconfig                           |   3 +
 drivers/media/mc/Makefile                          |   3 +-
 drivers/media/mc/mc-device.c                       | 236 ++++++++++++++-
 drivers/media/mc/mc-devnode.c                      |  19 +-
 drivers/media/mc/mc-entity.c                       |  59 ++++
 drivers/media/mc/mc-evbase.c                       | 260 +++++++++++++++++
 drivers/media/mc/mc-event.c                        | 244 ++++++++++++++++
 drivers/media/pci/ivtv/ivtv-fileops.c              |   2 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   |  36 ++-
 drivers/media/v4l2-core/v4l2-ctrls-api.c           |  16 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |  20 +-
 drivers/media/v4l2-core/v4l2-event.c               | 324 +++++++++------------
 drivers/media/v4l2-core/v4l2-fh.c                  |  12 +-
 include/media/media-device.h                       |  24 ++
 include/media/media-devnode.h                      |  18 +-
 include/media/media-entity.h                       |  77 +++++
 include/media/media-evbase.h                       | 200 +++++++++++++
 include/media/media-event.h                        | 181 ++++++++++++
 include/media/media-fh.h                           |  37 +++
 include/media/v4l2-event.h                         | 106 ++++---
 include/media/v4l2-fh.h                            |  32 +-
 include/uapi/linux/media.h                         |  51 +++-
 28 files changed, 2079 insertions(+), 338 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20260923-v4l2-sensor-detect-32a0b2936cc1

Best regards,
--  
Mattijs Korpershoek <mkorpershoek@kernel.org>

